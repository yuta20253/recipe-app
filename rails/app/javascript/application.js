// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@rails/ujs"

document.addEventListener("turbo:load", function () {
  const container = document.getElementById("instructions-container");
  const addButton = document.getElementById("add-step-button");
  const form = document.querySelector("form");
  const hiddenInput = document.getElementById("compiled_instructions");
  let stepCount = 1;

  addButton.addEventListener("click", function (event) {
    event.preventDefault();
    stepCount++;

    const newDiv = document.createElement("div");
      newDiv.className = "instruction-field mb-2";

      const label = document.createElement("label");
      label.innerText = `手順 ${stepCount}`;

      const input = document.createElement("input");
      input.type = "text";
      input.name = "users_recipe_form[instructions][]";
      input.className = "form-control";

      newDiv.appendChild(label);
      newDiv.appendChild(input);
      container.appendChild(newDiv);
  });

  form.addEventListener("submit", function () {
    const inputs = document.querySelectorAll('input[name="users_recipe_form[instructions][]"]');
    const steps = [];

    inputs.forEach((input, index) => {
        const value = input.value.trim();
        if (value !== "") {
            steps.push(`${index + 1}. ${value}`);
        }
    });
    hiddenInput.value = steps.join("\n");
  })

});
