
var toggleBtn = document.querySelector('.navToggleBtn');
var menu = document.querySelector('.mainMenu');

if (toggleBtn != null) {
        toggleBtn.addEventListener('click', function () {
        menu.classList.toggle('active');
    });
}


var reviewToggleBtn = document.querySelector('.reviewToggleBtn');
var review = document.querySelector('.review');

if (reviewToggleBtn != null ) {
	reviewToggleBtn.addEventListener('click', function () {
	    review.classList.toggle('active');
	}); 
}


var changeMyInfodToggle = document.querySelector('.changeMyInfodToggle');
var wrapMyInfoDetail = document.querySelector('.wrapMyInfoDetail');

if (changeMyInfodToggle != null) {
	changeMyInfodToggle.addEventListener('click', function () {
	    wrapMyInfoDetail.classList.toggle('active');
	    document.documentElement.scrollTop = 300;
	});
}


var exitchangePasswordBtn = document.querySelector('.exitchangePasswordBtn');
var changePassword = document.querySelector('.changePassword');

if (exitchangePasswordBtn != null) {
	exitchangePasswordBtn.addEventListener('click', function () {
	    changePassword.classList.toggle('active');
	    document.documentElement.scrollTop = 200;
	});
}

if (document.querySelector(".copy-Phone") != null) {
	document.querySelector(".copy-Phone").addEventListener("click", function(){
	  var tempElem = document.createElement('textarea');
	  tempElem.value = '010-3214-5324';  
	  document.body.appendChild(tempElem);
	
	  tempElem.select();
	  document.execCommand("copy");
	  document.body.removeChild(tempElem);
	  alert("copied");
	});
	
	document.querySelector(".copy-email").addEventListener("click", function(){
	  var tempElem = document.createElement('textarea');
	  tempElem.value = 'KCK0827@gmail.com';  
	  document.body.appendChild(tempElem);
	
	  tempElem.select();
	  document.execCommand("copy");
	  document.body.removeChild(tempElem);
	  alert("copied");
	});
	
	document.querySelector(".copy-address").addEventListener("click", function(){
	  var tempElem = document.createElement('textarea');
	  tempElem.value = '경기도 수원시 팔달구 매산동 매산로 12-1';  
	  document.body.appendChild(tempElem);
	
	  tempElem.select();
	  document.execCommand("copy");
	  document.body.removeChild(tempElem);
	  alert("copied");
	});
}

function goTop(){
	console.log('go top')
	document.documentElement.scrollTop = 0;
};

