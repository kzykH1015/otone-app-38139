function list () {
  const contentList = document.getElementById("content-lists");
  const pullDown = document.getElementById("pull-down");
  const listChild = document.querySelectorAll(".list-child");
  const selectContent = document.getElementById("select-content-title")
  const idChild = document.querySelectorAll(".select-id-child")
  const hiddenId = document.getElementById("hidden-id")

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
      // idChild.forEach((id, i) => {
      //   const selectId = id.textContent
      //   hiddenId.value = selectId;
      // });
    });
  });
  
  
};

window.addEventListener('load',list);