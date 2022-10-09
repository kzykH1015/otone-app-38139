document.addEventListener("DOMContentLoaded", () => {
  const genreNameInput = document.getElementById("genre-name")
  if (genreNameInput){
    console.log("読み込み")
    genreNameInput.addEventListener("input", () => {
      const keyword = document.getElementById("genre-name").value;
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `/contents/search_genre/?keyword=${keyword}`, true)
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        const searchResult = document.getElementById("genre-search-result");
        searchResult.innerHTML = "";
        if (XHR.response){
          const genreName = XHR.response.keyword;
          genreName.forEach((genre) => {
            const childElement = document.createElement("div");
            childElement.setAttribute("class", "child");
            childElement.setAttribute("id", genre.id);
            childElement.innerHTML = genre.genre_name;
            searchResult.appendChild(childElement);

            const clickElement = document.getElementById(genre.id);
            clickElement.addEventListener("click", () => {
              document.getElementById("genre-name").value = clickElement.textContent;
              clickElement.remove();
            })
          });
        };
      };
    });
  };

});