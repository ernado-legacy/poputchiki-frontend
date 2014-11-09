app.models.Ad = Backbone.Model.extend
	urlRoot: '/api/ads'

app.models.Ads = Backbone.Collection.extend
	url: '/api/ads'