koa = require 'koa'
route = require 'koa-route'
toMarkdown = require 'to-markdown'
{readabilityFetchContent} = require './utils'
leaApiGetter = require './lea-api'
leaLogin = leaApiGetter.login

HOST = process.env.HOST or '0.0.0.0'
PORT = process.env.PORT or '8080'

app = koa()

app.use route.get '/favour',->
  {token,email,pwd,url,notebook,notebookId} = @query

  try
    token = yield leaLogin(email,pwd) if (not token) and (email and pwd)
  catch err
    @throw(400,'Login error.')

  @throw(400,'No token or login info provided.') unless token
  @throw(400,'No url provided.') unless url
  @throw(400,'No notebook info provided.') if (not notebook) and (not notebookId)

  api = leaApiGetter(token)

  notebooks = yield api.getNotebooks() unless notebookId
  notebookMatched = (notebooks.filter (v)->v.name == notebook)

  @throw(400,'No notebook matched.') if notebookMatched.length < 1
  notebookId = notebookMatched[0].id

  title=null
  content=null

  try
    {title,content} = yield readabilityFetchContent(url)
  catch err
    @throw(400,"Readability error.#{JSON.stringify(err)}")

  content = toMarkdown(content)
#  console.log(content)
  result = null

  try
    result = yield api.addNote(title,notebookId,content)
  catch err
    @throw(400,"Leanote Server error.#{JSON.stringify(err)}")

  @throw(400,"Error #{JSON.stringify(result)}") if result['Ok'] and result['Ok']==false

  @body = result

app.listen(PORT)
console.log("app listen on #{PORT}")