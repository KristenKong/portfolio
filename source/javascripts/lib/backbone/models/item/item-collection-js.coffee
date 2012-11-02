_NS = @__get_project_namespace__()
_MODELS = @__get_project_namespace__ [ "Models" ]

class _MODELS.ItemCollection extends _MODELS.BaseCollection

  className : "ItemCollection"

  model : _MODELS.ItemModel

  comparitor : (model) -> model.get "index"