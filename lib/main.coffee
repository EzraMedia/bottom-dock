{CompositeDisposable} = require('atom')
BottomDockService = require('./bottom-dock-service')
BottomDockServiceV0 = require('./bottom-dock-service-v0')
BottomDock = require('./views/bottom-dock')

module.exports =
  config:
    tabsOnBottom:
      type: 'boolean'
      default: true
      
  activate: (state) ->
    @bottomDock = new BottomDock()
    @subscriptions = new CompositeDisposable()

    @subscriptions.add(atom.commands.add('atom-workspace',
      'bottom-dock:toggle': => @bottomDock.toggle()
    ))
    @subscriptions.add(atom.commands.add('atom-workspace',
      'bottom-dock:delete': => @bottomDock.deleteCurrentPane()
    ))
    @subscriptions.add(atom.commands.add('atom-workspace',
      'bottom-dock:refresh': => @bottomDock.refreshCurrentPane()
    ))

  provideBottomDock: () ->
    @bottomDockService = new BottomDockService(@bottomDock)
    return @bottomDockService

  provideBottomDockV0: () ->
    @bottomDockServiceV0 = new BottomDockServiceV0(@bottomDock)
    return @bottomDockServiceV0

  deactivate: ->
    @subscriptions.dispose()
    @bottomDockServiceV0.destroy()
    @bottomDockService.destroy()
    @bottomDock.destroy()
