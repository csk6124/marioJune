MyApp = require 'application'

###
# # Util
#
# * 유틸 클래스
#
###
class Util
	###
	# ## constructor
	#
	# 	@param null
	###
	constructor: ->


	###
	# ## isNullOrEmpty
	#
	# 	is null or empty or undefined checking
	# 	@param string 
	# 	@param length
	# 	@return true or false 
	###
	isNullOrEmpty: (string, length=0) ->
		if _.isUndefined(string)
			return true
		if _.isNull(string)
			return true
		if _.isEmpty(string)
			return true
		if string.length <= length
			return true

		return false

		
	###
	# ## callAjaxForElastic
	#
	# 	ajax remote call to api
	# 	@param callback
	#   @return null sucess or error log
	###
	callAjaxForElastic: (callback) ->
		$.ajax
		  timeout: 15000
		  url: MyApp.elasticsearch_path + '_aliases'
		  type: 'GET'
		  dataType: 'json'
		  contentType: "application/json"
		  success: (data, status, jqXHR) =>
		  	callback('success', data)
		  error: (jqXHR, status) =>
		    callback('error', status)


	###
	# ## callAjax
	#
	# 	ajax remote call to api
	# 	@param data (JSON.stringify string data, fullpath url, type for method as POST, PUT, PATCH, DELETE
	# 	@param callback
	# 	@return null sucess or error log
	###
	callAjax: (datas, callback) ->
		# 현재 테스트용도임...  로그인후 key값을 전달하는 작업..
		if @isNullOrEmpty(datas.data)
			sha = CryptoJS.HmacSHA1('', "ef1a762d28eda40a6eae2a85b287051d8b4a1e01")
		else
			sha = CryptoJS.HmacSHA1(JSON.stringify(datas.data), "ef1a762d28eda40a6eae2a85b287051d8b4a1e01")

		headers = {}
		headers['x-user-signature'] = sha.toString()
		headers['x-user-publicId'] = "watermelon"
		headers['x-user-expire'] = new Date().getTime()

		MyApp.log 'callAjax', datas.data, datas.url, datas.type, headers
		$.ajax
		  timeout: 5000
		  headers: headers
		  data: JSON.stringify(datas.data)
		  url: datas.url
		  type: datas.type
		  crossDomain: true
		  xhrFields:
          	'withCredentials': true
          ,
		  dataType: 'json'
		  contentType: "application/json"
		  success: (data, status, jqXHR) =>
		  	callback('success', data)
		  error: (jqXHR, status) =>
		    callback('error', status)

		    
	###
	# ## getElasticsearchData
	# 
	# 	@param options array
	# 	@param info search info
	# 	@return result object
	###
	getElasticsearchData: (option, info) ->
		ejs.client = ejs.jQueryClient(info.elasticsearch)
		request = ejs.Request().indices(info.indices)

		someQuery = toEjsQueryStringObj(option)
		someFilter = getEjsBoolFilter(option)
		query = ejs.FilteredQuery(someQuery, someFilter)
		queryFilter = ejs.QueryFilter(query)

		facet = ejs.DateHistogramFacet(option.ids[0])

		if option.mode is 'count'
			facet = facet.field(option.field)
		else 
			facet = facet.keyField(option.field)
			facet = facet.valueField(null)
			facet = facet.global(true)
	
		facet = facet.interval(option.interval)
		facet = facet.facetFilter(queryFilter)
		request = request.facet(facet).size(0);
		results = request.doSearch()
		return results

	###
	# ## getEjsBoolFilter
	#
	# 	@private function
	#   @param option object
	# 	@return ejs object
	###
	getEjsBoolFilter = (option) ->
	  bool = ejs.BoolFilter().must(ejs.MatchAllFilter())
	  either_bool = ejs.BoolFilter().must(ejs.MatchAllFilter())
	  
	  _.each option.ids, (id) =>
	  	if option.active
	      switch option.mandate
	        when "mustNot"
	          bool = bool.mustNot(toEjsObj(option))
	        when "either"
	          either_bool = either_bool.should(toEjsObj(option))
	        else
	          bool = bool.must(toEjsObj(option))

	  bool.must either_bool


	###
	# ## toEjsObj
	#
	# 	@param filter option object
	# 	@return facet
	###
	toEjsObj = (filter) ->
	  return false  unless filter.active
	  switch filter.type
	    when "time"
	      _f = ejs.RangeFilter(filter.field).from(kbn.parseDate(filter.from).valueOf())
	      _f = _f.to(filter.to.valueOf())  unless _.isUndefined(filter.to)
	      _f
	    when "range"
	      ejs.RangeFilter(filter.field).from(filter.from).to filter.to
	    when "querystring"
	      ejs.QueryFilter(ejs.QueryStringQuery(filter.query)).cache true
	    when "field"
	      ejs.QueryFilter(ejs.FieldQuery(filter.field, filter.query)).cache true
	    when "terms"
	      ejs.TermsFilter filter.field, filter.value
	    when "exists"
	      ejs.ExistsFilter filter.field
	    when "missing"
	      ejs.MissingFilter filter.field
	    else
	      false

	###
	# ## toEjsQueryStringObj
	#
	# 	@param option object
	# 	@return querystring format
	###
	toEjsQueryStringObj = (option) ->
	  switch option.query_type
	    when "lucene"
	      ejs.QueryStringQuery option.query or "*"
	    when "regex"
	      ejs.RegexpQuery "_all", option.query
	    else
	      false


module.exports = Util