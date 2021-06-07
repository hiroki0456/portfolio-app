const pay = () => {
  console.log('test')
Payjp.setPublicKey("pk_test_7acaf09842ce98080d0e3820");
const form = document.getElementById("card_form");
form.addEventListener("submit", (e) => {
  e.preventDefault();

  const formResult = document.getElementById("card_form");
  const formData = new FormData(formResult);

  const card = {
    number: formData.get("card[card_number]"),
    cvc: formData.get("card[cvc]"),
    exp_month: formData.get("card[exp_month]"),
    exp_year: `20${formData.get("card[exp_year]")}`,
  };

  Payjp.createToken(card, (status, response) => {
    if (status === 200) {
      const token = response.id;
      const renderDom = document.getElementById("card_form");
      const tokenObj = `<input value=${token} name='card[token]' type="hidden">`;
      renderDom.insertAdjacentHTML("beforeend", tokenObj);

      document.getElementById("card_card_number").removeAttribute("name");
      document.getElementById("card_exp_month").removeAttribute("name");
      document.getElementById("card_exp_year").removeAttribute("name");
      document.getElementById("card_cvc").removeAttribute("name");

      document.getElementById("card_form").submit();
    }
  });
});
};

window.addEventListener("load", pay);