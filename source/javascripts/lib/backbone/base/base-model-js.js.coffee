_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

_setupRoute = ->
  model = @
  parent = @get 'parent'
  fragments = []
  fragment = model.get 'fragment'
  if fragment then fragments.unshift fragment
  
  while parent isnt undefined
    model = parent
    fragment = model.get 'fragment'
    if fragment then fragments.unshift fragment
    parent = parent.get 'parent'

  @set 'fragments', fragments
    
  @

_setupItems = (item) ->
  items = item["items"]
  
  if items isnt null and items isnt undefined and items.length isnt 0
    # Model has a branch node, creating an item collection
    itemCollection = new _MODELS.ItemCollection
    @set 'itemCollection', itemCollection
    
    # Add on ready event handlers
    itemsReady = 0
    itemsTotal = items.length
    eventType = @EVENTBUS.eventTypes.MODEL_READY
    
    itemCollection.on eventType, (model) =>
      if ++itemsReady is itemsTotal
        parent = @get 'parent'
        if parent
          parent.trigger eventType
        else
          # @log '>>> Main Model is ready.'
          setTimeout (=>
            # @log '>>> Wait for MODEL_READY event to bind and trigger.'
            # TODO : [RKP] : This is a hack.
            @trigger eventType
            ), 1
    
    # Add additional attributes
    _.each items, (item, index) =>
      item.index = index
      item.parent = @
    
    itemCollection.add items

  @

_setup = ->
  @ROUTER = _NS.navigationRouter
  @EVENTBUS = _NS.eventBus
  
  options = [ 
    silent : true 
  ]
  
  # Do special nested model stuff
  item = @get "item"
  if item isnt undefined
    @set item, options
    @unset "item", options
    _setupRoute.call @
    _setupItems.call @, item
  
  @
  
_init = ->
  @addProperties()
  @  
  
class _MODELS.BaseModel extends Backbone.Model

  className : "BaseModel"
  NS : _NS
  MODELS : _MODELS
  ROUTER : undefined
  EVENTBUS : undefined
  
  initialize : ->
    @log = _NS.log @className
    # @log "initialize"
    _setup.call @
    _init.call @
    @
    
  addProperties : ->
    # @log "addProperties"
    
    @createAttributeFromFragments 'dom', '-'
    @createAttributeFromFragments 'route', '/'
    @createAttributeFromFragments 'file', '_'
    
    @
    
  createAttributeFromFragments : (name, separator) ->
    @set name, ( @get 'fragments' ).join separator
    
