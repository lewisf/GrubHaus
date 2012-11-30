/**
 * almond 0.2.0 Copyright (c) 2011, The Dojo Foundation All Rights Reserved.
 * Available via the MIT or new BSD license.
 * see: http://github.com/jrburke/almond for details
 */
//Going sloppy to avoid 'use strict' string cost, but strict practices should
//be followed.
/*jslint sloppy: true */
/*global setTimeout: false */
var requirejs,require,define;(function(e){function l(e,t){var n,r,i,s,o,a,f,l,c,h,p=t&&t.split("/"),d=u.map,v=d&&d["*"]||{};if(e&&e.charAt(0)==="."&&t){p=p.slice(0,p.length-1),e=p.concat(e.split("/"));for(l=0;l<e.length;l+=1){h=e[l];if(h===".")e.splice(l,1),l-=1;else if(h===".."){if(l===1&&(e[2]===".."||e[0]===".."))break;l>0&&(e.splice(l-1,2),l-=2)}}e=e.join("/")}if((p||v)&&d){n=e.split("/");for(l=n.length;l>0;l-=1){r=n.slice(0,l).join("/");if(p)for(c=p.length;c>0;c-=1){i=d[p.slice(0,c).join("/")];if(i){i=i[r];if(i){s=i,o=l;break}}}if(s)break;!a&&v&&v[r]&&(a=v[r],f=l)}!s&&a&&(s=a,o=f),s&&(n.splice(0,o,s),e=n.join("/"))}return e}function c(t,r){return function(){return n.apply(e,f.call(arguments,0).concat([t,r]))}}function h(e){return function(t){return l(t,e)}}function p(e){return function(t){s[e]=t}}function d(n){if(o.hasOwnProperty(n)){var r=o[n];delete o[n],a[n]=!0,t.apply(e,r)}if(!s.hasOwnProperty(n)&&!a.hasOwnProperty(n))throw new Error("No "+n);return s[n]}function v(e){var t,n=e?e.indexOf("!"):-1;return n>-1&&(t=e.substring(0,n),e=e.substring(n+1,e.length)),[t,e]}function m(e){return function(){return u&&u.config&&u.config[e]||{}}}var t,n,r,i,s={},o={},u={},a={},f=[].slice;r=function(e,t){var n,r=v(e),i=r[0];return e=r[1],i&&(i=l(i,t),n=d(i)),i?n&&n.normalize?e=n.normalize(e,h(t)):e=l(e,t):(e=l(e,t),r=v(e),i=r[0],e=r[1],i&&(n=d(i))),{f:i?i+"!"+e:e,n:e,pr:i,p:n}},i={require:function(e){return c(e)},exports:function(e){var t=s[e];return typeof t!="undefined"?t:s[e]={}},module:function(e){return{id:e,uri:"",exports:s[e],config:m(e)}}},t=function(t,n,u,f){var l,h,v,m,g,y=[],b;f=f||t;if(typeof u=="function"){n=!n.length&&u.length?["require","exports","module"]:n;for(g=0;g<n.length;g+=1){m=r(n[g],f),h=m.f;if(h==="require")y[g]=i.require(t);else if(h==="exports")y[g]=i.exports(t),b=!0;else if(h==="module")l=y[g]=i.module(t);else if(s.hasOwnProperty(h)||o.hasOwnProperty(h)||a.hasOwnProperty(h))y[g]=d(h);else{if(!m.p)throw new Error(t+" missing "+h);m.p.load(m.n,c(f,!0),p(h),{}),y[g]=s[h]}}v=u.apply(s[t],y);if(t)if(l&&l.exports!==e&&l.exports!==s[t])s[t]=l.exports;else if(v!==e||!b)s[t]=v}else t&&(s[t]=u)},requirejs=require=n=function(s,o,a,f,l){return typeof s=="string"?i[s]?i[s](o):d(r(s,o).f):(s.splice||(u=s,o.splice?(s=o,o=a,a=null):s=e),o=o||function(){},typeof a=="function"&&(a=f,f=l),f?t(e,s,o,a):setTimeout(function(){t(e,s,o,a)},15),n)},n.config=function(e){return u=e,n},define=function(e,t,n){t.splice||(n=t,t=[]),o[e]=[e,t,n]},define.amd={jQuery:!0}})();