function message () {
  console.log('www')
  const moveEditBtn = document.getElementById("content-edit-btn");
  moveEditBtn.addEventListener('click', (e) => {
    console.log('kkk')
    e.preventDefault();
    e.returnValue = "hokano"
  });
};


window.addEventListener('load', message);