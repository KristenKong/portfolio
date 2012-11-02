_NS = @__get_project_namespace__()
_ob = @__get_project_namespace__ [ 'Environment' ]

_ob.DEVELOPMENT = 'development'
_ob.REVIEW = 'review'
_ob.STAGING = 'staging'
_ob.PRODUCTION = 'production'

_ob.type = window.__environment_type__ or _ob.PRODUCTION