(this["webpackJsonpchat-app"]=this["webpackJsonpchat-app"]||[]).push([[0],{10:function(e,t,s){},18:function(e,t,s){},20:function(e,t,s){"use strict";s.r(t);var a=s(1),c=s.n(a),n=s(11),r=s.n(n),i=s(2),l=s(4),o=s.n(l),j=s(8),d=s(3),u=s.n(d),b=(s(18),s(0));var h=function(){return Object(b.jsx)(b.Fragment,{children:Object(b.jsxs)("div",{id:"logingPage",className:"loginBox",children:[Object(b.jsx)("img",{className:"user",src:"https://i.ibb.co/yVGxFPR/2.png",height:"100px",width:"100px"}),Object(b.jsx)("h3",{children:"Sign in here"}),Object(b.jsxs)("form",{className:"form-group",onSubmit:function(){var e=Object(j.a)(o.a.mark((function e(t){var s,a,c,n;return o.a.wrap((function(e){for(;;)switch(e.prev=e.next){case 0:return t.preventDefault(),s=u()("#username").val(),a=u()("#password").val(),e.next=5,fetch("http://localhost:8080/signin/"+s+"/"+a);case 5:return c=e.sent,e.next=8,c.json();case 8:n=e.sent,console.log(s,a,n),"invalid username or password"===n.response?alert("invalid username or password"):(localStorage.setItem("jwt",n.response),window.location.reload());case 11:case"end":return e.stop()}}),e)})));return function(t){return e.apply(this,arguments)}}(),children:[Object(b.jsxs)("div",{className:"inputBox",children:[Object(b.jsx)("input",{style:{borderRadius:"10px",border:"1px solid #ccc",paddingLeft:"10px",paddingRight:"10px",paddingTop:"5px",paddingBottom:"5px",width:"100%",height:"40px"},id:"username",type:"text",name:"Username",placeholder:"Username"}),Object(b.jsx)("input",{style:{borderRadius:"10px",border:"1px solid #ccc",paddingLeft:"10px",paddingRight:"10px",paddingTop:"5px",paddingBottom:"5px",width:"100%",height:"40px"},id:"password",type:"password",name:"Password",placeholder:"Password"})]}),Object(b.jsx)("input",{type:"submit",name:"",value:"Login"})]})," ",Object(b.jsxs)("a",{href:"#",children:["Forget Password",Object(b.jsx)("br",{})," "]}),Object(b.jsx)("div",{className:"text-center",children:Object(b.jsx)("p",{style:{color:"white",fontSize:"20px",fontWeight:"bold",marginTop:"10px",float:"left",padding:"10px",textAlign:"left"},children:"Sign-Up"})})]})})},x=(s(10),Object(a.createContext)()),m=function(e){var t=e.children,s=Object(a.useState)({}),n=Object(i.a)(s,2),r=n[0],l=n[1],d=Object(a.useState)(""),u=Object(i.a)(d,2),h=u[0],m=u[1],p=Object(a.useState)({}),O=Object(i.a)(p,2),f=O[0],g=O[1],v=Object(a.useState)(null),N=Object(i.a)(v,2),w=N[0],S=N[1],y=Object(a.useState)([]),D=Object(i.a)(y,2),I=D[0],F=D[1],k=Object(a.useState)(""),C=Object(i.a)(k,2),T=C[0],U=C[1];return null!=w&&(w.onopen=function(){w.send("id-Client "+r.id)}),c.a.useEffect(Object(j.a)(o.a.mark((function e(){var t,s,a;return o.a.wrap((function(e){for(;;)switch(e.prev=e.next){case 0:return t=localStorage.getItem("jwt"),e.next=3,fetch("http://localhost:8080/user/"+t);case 3:return s=e.sent,e.next=6,s.json();case 6:a=e.sent,S(new WebSocket("ws://localhost:8080/send")),l(a);case 9:case"end":return e.stop()}}),e)}))),[]),window.onbeforeunload=function(){w.send("disconnect-client "+r.id)},Object(b.jsx)(x.Provider,{value:{user:r,setUser:l,userInputText:h,setUserInputText:m,messages:I,setMessages:F,friendID:T,setFriendID:U,connection:w,setConnection:S,currentFriend:f,setCurrentFriend:g},children:t})};var p=function(e){var t=e.message,s=c.a.useState(t),a=Object(i.a)(s,2),n=a[0];return a[1],Object(b.jsx)(b.Fragment,{children:Object(b.jsxs)("li",{className:"clearfix",children:[Object(b.jsx)("div",{className:"message-data",children:Object(b.jsx)("span",{className:"message-data-time",children:n.date})}),Object(b.jsx)("div",{className:"message my-message",children:n.content})]})})};var O=function(e){var t=e.message,s=c.a.useState(t),a=Object(i.a)(s,2),n=a[0];return a[1],Object(b.jsx)(b.Fragment,{children:Object(b.jsxs)("li",{className:"clearfix",children:[Object(b.jsx)("div",{className:"message-data text-right",children:Object(b.jsx)("span",{style:{fontSize:10},className:"message-data-time",children:n.date})}),Object(b.jsx)("div",{style:{backgroundColor:"#86c541"},className:"message other-message float-right my-message",children:n.content})]})})};var f=function(e){var t=e.userFriend,s=c.a.useState(t),a=Object(i.a)(s,2),n=a[0];return a[1],Object(b.jsxs)("li",{className:"clearfix",children:[Object(b.jsx)("img",{src:n.avatar,alt:"avatar"}),Object(b.jsxs)("div",{className:"about",children:[Object(b.jsx)("div",{className:"name",children:n.name}),Object(b.jsxs)("div",{className:"status",children:[Object(b.jsx)("i",{className:"fa fa-circle online"})," online"]})]})]})};var g=function(e){var t=e.user;return Object(b.jsxs)("div",{className:"col-lg-6",children:[Object(b.jsx)("a",{href:"javascript:void(0);","data-toggle":"modal","data-target":"#view_info",children:Object(b.jsx)("img",{src:t.avatar,alt:"avatar"})}),Object(b.jsxs)("div",{className:"chat-about",children:[Object(b.jsx)("h6",{className:"m-b-0",children:t.name}),Object(b.jsx)("small",{children:"Last seen: 2 hours ago"})]})]})};var v=function(){return Object(b.jsxs)("div",{className:"col-lg-6 hidden-sm text-right",children:[Object(b.jsx)("a",{href:"javascript:void(0);",className:"btn btn-outline-secondary",children:Object(b.jsx)("i",{className:"fa fa-camera"})}),Object(b.jsx)("a",{href:"javascript:void(0);",className:"btn btn-outline-primary",children:Object(b.jsx)("i",{className:"fa fa-image"})}),Object(b.jsx)("a",{href:"javascript:void(0);",className:"btn btn-outline-info",children:Object(b.jsx)("i",{className:"fa fa-cogs"})}),Object(b.jsx)("a",{href:"javascript:void(0);",className:"btn btn-outline-warning",children:Object(b.jsx)("i",{className:"fa fa-question"})})]})},N=s(5),w=s(12),S=function e(t,s,a,c,n){Object(w.a)(this,e),this.id=t,this.content=s,this.MyUserID=a,this.date=c,this.userToID=n},y=(new S("","","","",""),new Date);y=y.toLocaleString("en-US",{dateStyle:"medium",timeStyle:"medium",hour12:!0});var D=function(e){var t=e.messageData,s=e.setMessageData,n=Object(a.useContext)(x),r=n.messages,l=n.friendID,o=n.connection,j=n.user,d=Object(a.useState)(new Date),u=Object(i.a)(d,2),h=(u[0],u[1],Object(a.useState)("")),m=Object(i.a)(h,2),p=m[0],O=m[1],f=Object(a.useState)(j.id),g=Object(i.a)(f,2),v=g[0],w=g[1];return c.a.useEffect((function(){null!=o&&(o.onmessage=function(e){var t=JSON.parse(e.data);console.log(t),s((function(e){return[].concat(Object(N.a)(e),[t])}))}),w(j.id)}),[v,o,l,p,O,j]),Object(b.jsxs)("div",{className:"chat-message clearfix",children:[r.map((function(e){return Object(b.jsx)("h1",{children:e})})),Object(b.jsxs)("div",{className:"input-group mb-0",children:[Object(b.jsx)("div",{className:"input-group-prepend",children:Object(b.jsx)("span",{className:"input-group-text",children:Object(b.jsx)("i",{className:"fa fa-send"})})}),Object(b.jsx)("input",{type:"text",className:"form-control",placeholder:"Enter text here...",onKeyPress:function(e){var a=new S("001",p,v,y,l);a.date=y,a.content=e.target.value,a.userToID=l,a.MyUserID=v,"Enter"===e.key&&(s((function(e){return[].concat(Object(N.a)(t),[a])})),o.send("request-send "+JSON.stringify(a)),console.log(a,"newMSG"),e.target.value="",O(""))}})]})]})};var I=function(){return Object(b.jsxs)("div",{className:"input-group",children:[Object(b.jsx)("div",{className:"input-group-prepend",children:Object(b.jsx)("span",{className:"input-group-text",children:Object(b.jsx)("i",{className:"fa fa-search"})})}),Object(b.jsx)("input",{type:"text",className:"form-control",placeholder:"Search..."})]})};var F=function(){var e=Object(a.useContext)(x),t=e.user,s=e.id,n=e.setId,r=(e.friendID,e.setFriendID),l=c.a.useState([]),o=Object(i.a)(l,2),j=o[0],d=o[1];return c.a.useEffect((function(){u()(".chat-history").animate({scrollTop:1e4},"slow")}),[s,n]),Object(b.jsx)("div",{children:Object(b.jsx)("div",{style:{position:"relative",top:"10vh"},className:"container",children:Object(b.jsx)("div",{className:"row clearfix ",children:Object(b.jsx)("div",{className:"col-lg-12",children:Object(b.jsxs)("div",{className:"card chat-app  chat-container",children:[Object(b.jsxs)("div",{id:"plist",className:"people-list",children:[Object(b.jsx)(I,{}),Object(b.jsx)("ul",{className:"list-unstyled chat-list mt-2 mb-0",children:t.friends&&t.friends.map((function(e){return Object(b.jsx)("div",{onClick:function(){d(e.messages),r(e.id)},children:Object(b.jsx)(f,{userFriend:e})})}))})]}),Object(b.jsxs)("div",{className:"chat",children:[Object(b.jsx)("div",{className:"chat-header clearfix",children:Object(b.jsxs)("div",{className:"row",children:[Object(b.jsx)(g,{user:t}),Object(b.jsx)(v,{})]})}),Object(b.jsx)("div",{className:"chat-history",children:Object(b.jsx)("ul",{className:"m-b-0  chat-box",children:j.map((function(e){return Object(b.jsx)("div",{onClick:function(){r(e.userToID)},children:e.MyUserID===t.id?Object(b.jsx)(O,{message:e}):Object(b.jsx)(p,{message:e})})}))})}),Object(b.jsx)(D,{setMessageData:d,messageData:j})]})]})})})})})};var k={backgroundColor:"black",height:"200vh",top:-20,position:"relative"};var C=function(){var e=c.a.useState(""),t=Object(i.a)(e,2),s=t[0],a=t[1];return c.a.useEffect((function(){var e=localStorage.getItem("jwt");e&&a(e)}),[]),Object(b.jsx)(b.Fragment,{children:Object(b.jsx)("div",{style:s?k:{},children:Object(b.jsx)(m,{children:s?Object(b.jsx)(F,{}):Object(b.jsx)(h,{})})})})};r.a.render(Object(b.jsx)(C,{}),document.getElementById("root"))}},[[20,1,2]]]);
//# sourceMappingURL=main.28b76b3d.chunk.js.map