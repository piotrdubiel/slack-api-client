BaseClass = require './common/base_class'

class Reactions extends BaseClass

  endpoints:
    add: '/api/reactions.add'
    get: '/api/reactions.get'
    list: '/api/reactions.list'
    remove: '/api/reactions.remove'

  #
  # Official API Methods
  #
  add: (opts = {}, callback) ->
    @validate.obj opts, [ 'name' ]
    @request 'POST', @endpoints.add, opts, callback

  get: (opts = {}, callback) ->
    @request 'GET', @endpoints.get, opts, callback

  list: (opts = {}, callback) ->
    @request 'GET', @endpoints.list, opts, callback

  remove: (opts = {}, callback) ->
    @validate.obj opts, [ 'name' ]
    @request 'POST', @endpoints.remove, opts, callback

module.exports = Reactions
