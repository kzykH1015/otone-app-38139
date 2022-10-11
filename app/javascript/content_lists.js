function list () {
  const contentList = document.getElementById("content-lists");
  const pullDown = document.getElementById("pull-down");
  const listChild = document.querySelectorAll(".list-child");
  const selectContent = document.getElementById("select-content-title")

  contentList.addEventListener("mouseover",() => {
    contentList.setAttribute("style", "background-color: #FFBEDA;")
  });
  contentList.addEventListener("mouseout",() => {
    contentList.removeAttribute("style", "background-color: #FFBEDA;")
  });

  contentList.addEventListener("click", () => {
    if (pullDown.getAttribute("style") == "display: block;"){
      pullDown.removeAttribute("style", "display: block;")
    } else {
      pullDown.setAttribute("style", "display: block;")
    }
  });
  
  listChild.forEach((list) => {
    list.addEventListener("click", () => {
      const value = list.innerHTML
      selectContent.innerHTML = value    
    });
  });
  
  
};

window.addEventListener('load',list);