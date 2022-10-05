function like (){
  const submit = document.getElementById("like-star");
  submit.addEventListener('click',(e) => {
    e.preventDefault();
  })
};
console.log("読み込み")


window.addEventListener('load', like);