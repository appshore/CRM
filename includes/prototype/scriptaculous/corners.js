Effect.Corner=Class.create();Object.extend(Object.extend(Effect.Corner.prototype,Effect.Base.prototype),{hex2:function(A){var A=parseInt(A).toString(16);return(A.length<2)?"0"+A:A},gpc:function(B){for(;B&&B.nodeName.toLowerCase()!="html";B=B.parentNode){var A=Element.getStyle(B,"backgroundColor");if(A.indexOf("rgb")>=0){rgb=A.match(/\d+/g);return"#"+this.hex2(rgb[0])+this.hex2(rgb[1])+this.hex2(rgb[2])}if(A&&A!="transparent"){return A}}return"#ffffff"},getW:function(A){switch(this.fx){case"round":return Math.round(this.width*(1-Math.cos(Math.asin(A/this.width))));case"cool":return Math.round(this.width*(1+Math.cos(Math.asin(A/this.width))));case"sharp":return Math.round(this.width*(1-Math.cos(Math.acos(A/this.width))));case"bite":return Math.round(this.width*(Math.cos(Math.asin((this.width-A-1)/this.width))));case"slide":return Math.round(this.width*(Math.atan2(A,this.width/A)));case"jut":return Math.round(this.width*(Math.atan2(this.width,(this.width-A-1))));case"curl":return Math.round(this.width*(Math.atan(A)));case"tear":return Math.round(this.width*(Math.cos(A)));case"wicked":return Math.round(this.width*(Math.tan(A)));case"long":return Math.round(this.width*(Math.sqrt(A)));case"sculpt":return Math.round(this.width*(Math.log((this.width-A-1),this.width)));case"dog":return(A&1)?(A+1):this.width;case"dog2":return(A&2)?(A+1):this.width;case"dog3":return(A&3)?(A+1):this.width;case"fray":return(A%2)*this.width;case"notch":return this.width;case"bevel":return A+1}},initialize:function(B,I){B=$(B);I=(I||"").toLowerCase();var O=/keep/.test(I);var G=((I.match(/cc:(#[0-9a-f]+)/)||[])[1]);var A=((I.match(/sc:(#[0-9a-f]+)/)||[])[1]);this.width=parseInt((I.match(/(\d+)px/)||[])[1])||10;var J=/round|bevel|notch|bite|cool|sharp|slide|jut|curl|tear|fray|wicked|sculpt|long|dog3|dog2|dog/;this.fx=((I.match(J)||["round"])[0]);var C={T:0,B:1};var F={TL:/top|tl/.test(I),TR:/top|tr/.test(I),BL:/bottom|bl/.test(I),BR:/bottom|br/.test(I)};if(!F.TL&&!F.TR&&!F.BL&&!F.BR){F={TL:1,TR:1,BL:1,BR:1}}var L=document.createElement("div");L.style.overflow="hidden";L.style.height="1px";L.style.backgroundColor=A||"transparent";L.style.borderStyle="solid";var Q={T:parseInt(Element.getStyle(B,"paddingTop"))||0,R:parseInt(Element.getStyle(B,"paddingRight"))||0,B:parseInt(Element.getStyle(B,"paddingBottom"))||0,L:parseInt(Element.getStyle(B,"paddingLeft"))||0};if(/MSIE/.test(navigator.userAgent)){B.style.zoom=1}if(!O){B.style.border="none"}L.style.borderColor=G||this.gpc(B.parentNode);var K=Element.getHeight(B);for(var M in C){var E=C[M];L.style.borderStyle="none "+(F[M+"R"]?"solid":"none")+" none "+(F[M+"L"]?"solid":"none");var R=document.createElement("div");var H=R.style;E?B.appendChild(R):B.insertBefore(R,B.firstChild);if(E&&K!="auto"){if(Element.getStyle(B,"position")=="static"){B.style.position="relative"}H.position="absolute";H.bottom=H.left=H.padding=H.margin="0";if(/MSIE/.test(navigator.userAgent)){H.setExpression("width","this.parentNode.offsetWidth")}else{H.width="100%"}}else{H.margin=!E?"-"+Q.T+"px -"+Q.R+"px "+(Q.T-this.width)+"px -"+Q.L+"px":(Q.B-this.width)+"px -"+Q.R+"px -"+Q.B+"px -"+Q.L+"px"}for(var N=0;N<this.width;N++){var D=Math.max(0,this.getW(N));var P=L.cloneNode(false);P.style.borderWidth="0 "+(F[M+"R"]?D:0)+"px 0 "+(F[M+"L"]?D:0)+"px";E?R.appendChild(P):R.insertBefore(P,R.firstChild)}}}});