casper = require('casper')

c = 
  server: casper.create()
  remote: casper.create()
  done: (callback) =>
    @doneToCount ||= 2
    @doneToCount -= 1
    if @doneToCount == 0
      c.server.test.comment "done"
      callback()
    else
      c.server.test.comment "#{@doneToCount} remaining"


urls = 
  base: "http://localhost:3502"
  remote: "http://localhost:3502/remote.html"


c.server.start urls.base, ->
  @test.comment 'Starting Server'

c.server.then ->
  c.server.debugHTML('#num_players')
  @test.assertSelectorHasText '#num_players', '0 players', 'Expected no players'


  c.remote.start urls.remote, ->
    @test.comment 'Loading remote'
    @test.assertTitle 'Xircle Remote', 'Xircle remote title'

  c.remote.then ->
    @wait 200, ->
      c.server.debugHTML('#num_players')
      c.server.test.assertSelectorHasText '#num_players', '1 players', "Expected one player after registered"

  c.remote.thenOpen urls.base, ->
    @wait 200, ->
      c.server.debugHTML('#num_players')
      c.server.test.assertSelectorHasText '#num_players', '0 players', "Expected no player after player left"

  c.remote.run ->
    console.log 'done'
    @test.done()
    @exit()

c.server.run ->
  #All gets done in remote



