

app.directive('helloWorld',function() {

    return{

        restrict:'AE',
        replace: 'false',
        template: '<p style="background-color:{{color}}">Hello World',
        link: function(scope,elem,attrs){
            elem.bind('click',function(){
                elem.css('background-color','white');
                scope.$apply( function(){
                    scope.color="white";
                });
            });
            elem.bind('mouseover',function(){
               elem.css('cursor','pointer');
            });
        }

    };


});
