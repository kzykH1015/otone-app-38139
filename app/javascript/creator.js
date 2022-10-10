document.addEventListener("DOMContentLoaded", () => {
  const creatorNameInput = document.getElementById("creator-name")
  if (creatorNameInput){
    creatorNameInput.addEventListener("input", () => {
      const keyword = document.getElementById("creator-name").value;
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `/contents/search_creator/?keyword=${keyword}`, true)
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        const searchResult = document.getElementById("creator-search-result");
        searchResult.innerHTML = "";
        if (XHR.response){
          const creatorName = XHR.response.keyword;
          creatorName.forEach((creator) => {
            const childElement = document.createElement("div");
            childElement.setAttribute("class", "child");
            childElement.setAttribute("id", creator.id);
            childElement.innerHTML = creator.creator_name;
            searchResult.appendChild(childElement);

            const clickElement = document.getElementById(creator.id);
            clickElement.addEventListener("click", () => {
              document.getElementById("creator-name").value = clickElement.textContent;
              clickElement.remove();
            })
          });
        };
      };
    });
  };

});