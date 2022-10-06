function list () {
  const userList = document.getElementById("user-lists");
  const pullDown = document.getElementById("pull-down");
  const listChild = document.getElementById("list-child")

  userList.addEventListener("mouseover",() => {
    userList.setAttribute("style", "background-color: #FFBEDA;")
  });
  userList.addEventListener("mouseout",() => {
    userList.removeAttribute("style", "background-color: #FFBEDA;")
  });

  userList.addEventListener("click", () => {
    if (pullDown.getAttribute("style") == "display: block;"){
      pullDown.removeAttribute("style", "display: block;")
    } else {
      pullDown.setAttribute("style", "display: block;")
    }
  });
};




window.addEventListener('load',list);