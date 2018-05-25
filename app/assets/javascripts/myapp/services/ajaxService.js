myapp.service("ajaxService", ["$resource", function ($resource) {
    self = this

    self.ajaxCall = function (route) {
        res = $resource('/' + route + '/:id/:action.json', {id: '@id', action: '@action'}, {
            updatefx: {method: 'PUT'},
            delete: {method: 'DELETE'},
            postfx: {method: 'POST'},
            patch: {method: 'PATCH'},
            getfx: {method: 'GET'}
        })

        return res
    }
}])