function message () {
  const moveEditBtn = document.getElementById("content-edit-btn");
  moveEditBtn.addEventListener('click', (e) => {
    const select_message = confirm("編集画面では作品の情報が全て見えてしまいます\n移動して編集しますか？");

    if (select_message) {
      console.log('idousimasita')
    } else {
      console.log('yameta')
      e.preventDefault()
    };
  });
};

window.addEventListener('load', message);