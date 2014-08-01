app.models.Stripe = Backbone.Model.extend
	urlRoot: '/api/stripe'

app.models.Stripes = Backbone.Collection.extend
	url: '/api/stripe'