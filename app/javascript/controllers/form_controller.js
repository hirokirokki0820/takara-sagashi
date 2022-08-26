import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  userName() {
    const userForm = document.querySelector("#userForm")
    const userNameField = document.querySelector("#userNameField")
    const userPasswordField = document.querySelector("#userPassword")
    const userPasswordConfirmationField = document.querySelector("#userPasswordConfirmation")
    const userPasswordGroup = document.querySelector('#userPasswordGroup')

    const userName = document.querySelector("#userName")
    const userPassword = document.querySelector("#userPassword")
    const userPasswordConfirmation = document.querySelector("#userPasswordConfirmation")
    const userSubmitBtn = document.querySelector("#userSubmit")

    const userError = document.querySelector("#userError")


    let activeName;
    let nameRegex = /^([a-zA-Z0-9]{3,})$/; // 半角英数字3文字以上を表す正規表現
    if(!nameRegex.test(userName.value)){
      if(userName.value === ""){ // 入力フォームが空の場合
        userError.textContent = "表示名を入力してください";
        userError.style.color = "red";
        userName.style.border = "2px solid red";
        activeName = false;
      }else if(userName.value.length < 3){ // 文字数が3文字未満の場合
        userError.textContent = "３文字以上の半角英数字を入力してください";
        userError.style.color = "red";
        userName.style.border = "2px solid red";
        activeName = false;
      }else{
        userError.textContent = "有効な値(半角英数字)を入力してください";
        userError.style.color = "red";
        userName.style.border = "2px solid red";
        activeName = false;
      }
    }else{
      if(userName.value.length > 50){ // 文字数が50文字を超える場合
        userError.textContent = "表示名は50文字以内で入力してください";
        userError.style.color = "red";
        userName.style.border = "2px solid red";
        userSubmitActive -= 1;
        activeName = false;
      }else{ // バリデーションチェック完了時（OK時）の処理
        userName.style.border = "2px solid lightgreen";
        userError.textContent = "";
        activeName = true;
      }
    }

  }

  userPassword() {

  }

  itemForm() {

  }
}
