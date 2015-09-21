request = require 'request'

class BaseClass

  constructor: (@slack) ->

  throwError: (error) ->
    {error} = error
    new Error "#{error}"

  request: (method = 'GET', url = '', params = {}, callback) ->
    params.token = @slack.apiKey

    uri = "#{@slack.host}#{url}"
    request
      method: method
      uri: uri
      form: params if method is 'POST'
      qs: params if method isnt 'POST', (err, res, body) =>
        throw err if err
        try
          data = JSON.parse(body)
          if res.statusCode is 200
            unless data.ok
              callback @throwError data
            else
              callback null, data
          else
            callback @throwError data
        catch error
          callback @throwError error

  validate:
    obj: (options = {}, validation = []) ->
      validation.forEach (value) ->
        throw new Error "Missing #{value} parameter." unless options[value]
      true

    str: (param = '') ->
      throw new Error "Missing parameter." unless param
      true

    inclusion: (param = '', possibilities) ->
      unless param in possibilities
        throw new Error "#{param} isn't a possibility (#{possibilities})"
      true

  select: (collection = [], param = {}, type = 'one') ->
    @validate.str type, [ 'one', 'all' ]

    property = Object.keys(param)[0]
    selected = (item for item in collection when item[property] is param[property])

    if selected.length
      return selected[0] if type is 'one'
      return selected if type is 'all'
    else
      {}

module.exports = BaseClass
