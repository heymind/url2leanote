fetch  = require 'node-fetch'
he = require 'he'
htmlparser = require "htmlparser2"

READABILITY_TOKEN = process.env.READABILITY_TOKEN or "511719798a4df8ef1221d3ef5ce944013b59ec8e"

module.exports.readabilityFetchContent = (url)->
  fetch("https://www.readability.com/api/content/v1/parser?url=#{url}&token=#{READABILITY_TOKEN}")
  .then (res)->
    throw res.statusText unless res.ok
    res.json()
  .then (data)->
    data['content'] = he.decode(data['content'])
    data


module.exports.getLinks = (content)->
  console.log(content)
  images=[]
  parser = new htmlparser.Parser {
    onopentag:(name,attribs)=>
      images.push attribs.src if name == 'img' and attribs.src
  }
  parser.write(content)
  parser.end()
  images
#