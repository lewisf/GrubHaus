(function(){define(["backbone","views/recipe","views/dashboard","views/search","views/createRecipe"],function(e,t,n,r,i){var s,o;return s=e.Router.extend({routes:{"":"index","recipes/search/:q":"index",recipes:"showDashboard","recipes/create":"createRecipe","recipes/:id":"showRecipe"},start:function(){return e.history.start({pushState:!0})},index:function(e){var t;return e!=null?t=new r(e):t=new r,$("section.container").html(t.el)},showRecipe:function(e){var n;return n=new t({id:e}),$("section.container").html(n.el)},showDashboard:function(){var e;return e=new n,$("section.container").html(e.el)},createRecipe:function(){var e;return e=new i,$("section.container").html(e.el),e.render()}}),o=function(){return window.router=new s,window.router.start()},{initialize:o}})}).call(this);