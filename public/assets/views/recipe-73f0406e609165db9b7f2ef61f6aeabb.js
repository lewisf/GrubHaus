(function(){var e={}.hasOwnProperty,t=function(t,n){function i(){this.constructor=t}for(var r in n)e.call(n,r)&&(t[r]=n[r]);return i.prototype=n.prototype,t.prototype=new i,t.__super__=n.prototype,t};define(["backbone","handlebars","models/recipe","views/recipeTimeline","views/recipeIngredients","text!templates/recipe.html"],function(e,n,r,i,s,o){var u;return u=function(e){function u(){return u.__super__.constructor.apply(this,arguments)}return t(u,e),u.prototype.steps=[],u.prototype.timelineEl="#rcontainer",u.prototype.initialize=function(e){var t=this;return this.template=n.compile(o),this.model=new r({_id:e.id}),this.model.fetch({success:function(){return t.steps=[],_.each(t.model.attributes.steps,function(e){return t.steps.push(e)}),t.render(),t.renderTimeline(),t.renderIngredients()}})},u.prototype.render=function(){return console.log(this.model),this.$el.html(this.template(this.model.for_template())),$(".img-circle").first().css("background","url('"+this.model.attributes.photo+"')")},u.prototype.renderTimeline=function(){var e;return e=new i(this.steps)},u.prototype.renderIngredients=function(){var e;return e=new s(this.model.get("recipe_ingredients"))},u}(e.View)})}).call(this);