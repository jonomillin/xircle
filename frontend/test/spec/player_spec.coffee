require [], ->
  describe 'Player', ->
    describe '#indexOf()', ->
      it 'should return -1 when the value is not present', ->
        [1,2,3].indexOf(1).should.equal(0)
