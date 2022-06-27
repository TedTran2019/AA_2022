document.addEventListener("DOMContentLoaded", () => {
  const toggleLi = (e) => {
    const li = e.target;
    if (li.className === "visited") {
      li.className = "";
    } else {
      li.className = "visited";
    }
  };

  document.querySelectorAll("#restaurants li").forEach((li) => {
    li.addEventListener("click", toggleLi);
  });

  const addFavorite = () => {
    const container = document.querySelector(".list-container");
    const favInput = container.querySelector(".favorite-input");
    const favSubmit = container.querySelector(".favorite-submit");
    const favList = container.querySelector("ul#sf-places");

    favSubmit.addEventListener("click", (e) => {
      e.preventDefault();
      const newLi = document.createElement("li");
      newLi.textContent = favInput.value;
      favList.appendChild(newLi);
      favInput.value = "";
    })
  }

  addFavorite();
  const addPhoto = (container) => { 
    const photoInput = container.querySelector(".photo-url-input");
    const photoSubmit = container.querySelector(".photo-url-submit");
    const photoList = container.querySelector("ul#dog-photos");

    photoSubmit.addEventListener("click", (e) => {
      e.preventDefault();
      const newLi = document.createElement("li");
      newLi.innerHTML = `<img src="${photoInput.value}">`;
      photoList.appendChild(newLi);
      photoInput.value = "";
    })
  }

  const togglePhotoForm = (form) => {
    const togglePhotoBtn = document.querySelector(".photo-show-button");
    togglePhotoBtn.addEventListener("click", (e) => {
      e.preventDefault();
      form.classList.toggle("hidden");
    })
  }

  const photoForm = document.querySelector(".photo-form-container");
  togglePhotoForm(photoForm);
  addPhoto(photoForm);
});
