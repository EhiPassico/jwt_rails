myapp.controller('users_controller', ["$scope", "$filter", "$resource", "ajaxService", "$window", function ($scope, $filter, $resource, ajaxService, $window) {

    $scope.user = {}

    $scope.check_presence_of_username_password = function () {
        if ($scope.user.username != null && $scope.user.password != null) {
            return true
        } else {
            return false
        }
    }

    $scope.signup_user = function () {
        $scope.display_error_message = null

        if ($scope.check_presence_of_username_password() == true) {
            ajaxService.ajaxCall("users").postfx({
                user: $scope.user
            }, function (result) {
                if (result.status == 'success') {
                    $scope.display_error_message = result.message

                } else {
                    $scope.display_error_message = result.message
                }

            })
        } else {
            $scope.display_error_message = "please enter username/password"
        }

    }


    $scope.login_user = function () {
        $scope.display_error_message = null

        if ($scope.check_presence_of_username_password() == true) {
            ajaxService.ajaxCall("users").postfx({
                action: 'login_user',
                user: $scope.user
            }, function (result) {
                if (result.status == 'success') {
                    console.log(result)
                    $scope.display_error_message = result.message

                }
                else {
                    $scope.display_error_message = result.message
                }

            })
        } else {
            $scope.display_error_message = "please enter username/password"

        }
    }

}])