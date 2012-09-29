@__set_project_namespace__ [ "__PROJECT__", "BOILERPLATE" ]

_NS = @__get_project_namespace__()

_NS.Config ?= {}

_ob = _NS.Config

_ob.debug = window.__debug_flag__ || false
_ob.environment = window.__environment_type__
_ob.touchOS = if typeof window.ontouchstart isnt 'undefined' then true else false

_ob.loc = window.location
_ob.protocol = "#{_ob.loc.protocol}//"
_ob.port = if _ob.loc.port then ":#{_ob.loc.port}" else ""
_ob.url = "#{_ob.protocol}#{_ob.loc.hostname}#{_ob.port}"

_ob.FilePaths =
  mainData : "data/main.json"
  
_ob.Environments ?= {}
_ob.Environments.DEVELOPMENT = 'development'
_ob.Environments.REVIEW = 'review'
_ob.Environments.STAGING = 'staging'
_ob.Environments.PRODUCTION = 'production'

# Some Url config helpers.
_ob.fragments = _fragments =
  section : ""
  subpage : "/"
  content : "/"
  
_ob.Url =
  Routes :
    getSection : (section) -> "#{_fragments.section}#{section}"
    getSubpage : (subpage) -> "#{_fragments.subpage}#{subpage}"
    getContent : (content) -> "#{_fragments.content}#{content}"
  Matches :
    getSection : -> "#{_fragments.section}:section"
    getSubpage : -> "#{_fragments.section}:section#{_fragments.subpage}:subpage"
    getContent : -> "#{_fragments.section}:section#{_fragments.subpage}:subpage#{_fragments.content}:content"
  