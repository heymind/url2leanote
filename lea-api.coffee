fetch = require 'node-fetch'

DEFAULT_SERVER = "https://leanote.com"
#toFileField=(id,type,name)->{LocalFileId:id,Type:type,Title:name}


toQueryString = (data)->
  items = Object.keys(data).map (v)->
    value = data[v]
    value = encodeURIComponent(value) if  typeof (value) == 'string'
    "#{v}=#{value}"
  items.join('&')

module.exports = (token,server=DEFAULT_SERVER)->
#  addNote:(title,notebook,tags,content,isMarkdown,files)->
#    fileArray = files.map(({id,rawFn,type})->toFileField({id:id,type:'jpg',name:id}))
#    form = new FormData()
##    form.append("token",token)
#    form.append("NotebookId",notebook)
#    form.append("Title",title)
#    form.append('Content',content)
#    form.append('IsMarkdown',JSON.stringify(isMarkdown))
#    form.append('Tags',JSON.stringify(tags))
#    form.append('Files',JSON.stringify(fileArray))
#    files.forEach ({id,rawFn})=>
#      form.append("FileDatas[#{id}]",rawFn(),{knownLength: 5})
#    console.log(form)
#    fetch("#{server}/api/note/addNote?token=#{token}",{
#      method:"POST",
#      body:JSON.stringify({NotebookId:notebook,Title:title,IsMarkdown:isMarkdown,Files:fileArray}),
#      headers: {"Content-Length":form._overheadLength}
#    }).then (res)->
#      res.json()

  addNote:(title,notebook,content)->
#    console.log(toQueryString({NotebookId:notebook,Title:title,IsMarkdown:true,Content:content}))
    fetch("#{server}/api/note/addNote?token=#{token}",{
      method:'POST',
      body:toQueryString({NotebookId:notebook,Title:title,IsMarkdown:true,Content:content}),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded"
      }
    }).then (res)->res.json()

  getNotebooks:->
    fetch("#{server}/api/notebook/getNotebooks?token=#{token}")
    .then (res)->res.json()
    .then (notebooks)->notebooks.map (notebook)->{id:notebook['NotebookId'],name:notebook['Title']}

module.exports.login  = (email,pwd,server=DEFAULT_SERVER) ->
  fetch("#{server}/api/auth/login?email=#{email}&pwd=#{pwd}").then (res)->
    throw res.statusText unless res.ok
    res.json()
  .then (data)->
    throw data['Msg'] unless data['Ok']
    data.Token