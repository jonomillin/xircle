casper = require('casper')

c = 
  server: casper.create()
  remote: casper.create()
  done: (callback) =>
    @doneToCount ||= 2
    @doneToCount -= 1
    if @doneToCount == 0
      callback()
    else
      console.log "#{@doneToCount} remaining"


urls = 
  base: "http://localhost:3501"
  remote: "http://localhost:3501/remote.html"


c.server.start urls.base, ->
  @test.comment 'Starting Server'

c.server.then ->
  @test.assertSelectorHasText '#num_players', '0 players', 'Expected no players'

c.remote.start urls.remote, ->
  @test.comment 'Loading remote'
  @test.assertTitle 'Xircle Remote', 'Xircle remote title'

  this.wait 200, ->
    c.server.then ->
      @test.assertSelectorHasText '#num_players', '1 players', "Expected one player after registered"

c.server.run ->
  @test.done()
  c.done => @exit()

c.remote.run ->
  @test.done()
  c.done => @exit()



