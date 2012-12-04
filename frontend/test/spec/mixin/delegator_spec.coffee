define ['mixins/delegator'], (Delegator) ->
  class MyClass
    @delegate: { methods: ['foo', 'bar', 'subclassed'], to: 'delegatee' }
    delegatee: null
    subclassed: -> 'subclassed'

  Delegator.mixin(MyClass)

  set = beforeEach

  describe 'mixin/Delegator', ->

    set -> @delegatee = { foo: (-> true), bar: (-> true), subclassed: (-> true) }
    set -> @mock = sinon.mock(@delegatee)
    set ->
      @subject = new MyClass
      @subject.delegatee = @delegatee

    afterEach -> @mock.restore() if @mock
    
    it 'should delegate the named calls', ->
      @mock.expects('foo').withArgs('a','b',3)
      @subject.foo('a', 'b', 3)
      @mock.verify().should.be.true

    it 'should delegate multiple calls', ->
      @mock.expects('bar').withArgs('a','b',3)
      @subject.bar('a', 'b', 3)
      @mock.verify().should.be.true

    it 'should get the right responses', ->
      @mock.expects('foo').returns(['hi', 'there'])
      @subject.foo().should.eql ['hi', 'there']

    it 'should not override methods', ->
      @mock.expects('subclassed').never
      @subject.subclassed().should.equal 'subclassed'
