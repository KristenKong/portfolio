@__set_project_namespace__ [ "__KRISTEN_KONG__", "PORTFOLIO" ]

_NS = @__get_project_namespace__()
_ob = @__get_project_namespace__ [ 'Config' ]

_ob.FilePaths =
  mainData : "data/main.json"

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
  