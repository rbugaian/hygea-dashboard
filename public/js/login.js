function onLogin_Click() {
        var email = document.getElementById("inputEmail").value;
        var password = document.getElementById("inputPassword").value;

        // $.post("127.0.0.1:3000/sessions", 
        // {
        // 	email:email,
        // 	password:password
        // },
        // onAjaxSuccess)
        // .fail( function(XMLHttpRequest, textStatus, errorThrown) {
        // 	console.log("fail: " + errorThrown + " textStatus: " + textStatus);
        // })
        // .complete( function);
        var data = {
        	email:email,
         	password:password
        };


$.ajax({
	type: "POST",
    url: "/sessions",
    data:JSON.stringify({
        "email": email,
        "password": password
    }),
    dataType:"json",
    contentType:"application/json",
    success:function(data, textStatus, jqXHR){
        console.log("HTTP Request Succeeded: " + jqXHR.status);
        console.log(data);
    },
    error:function(jqXHR, textStatus, errorThrown){
        console.log("HTTP Request Failed");
    }
});
        // var xmlhttp = new window.XMLHttpRequest();

  //       $.ajax({
  // 			type: "POST",
  // 			url: "http://localhost:3000/sessions",
  // 			data: data,
  // 			success: onAjaxSuccess,
  // 			dataType: "JSON",
  // 			fails:onRequestError,
  // 			always:onRequestError
		// });

		// xmlhttp.open("POST","http://localhost:3000/sessions", true);

		// xmlhttp.inreadystatechange = function() {
		// 	console.log(xmlhttp.readyState + " " + xmlhttp.status);
		// };

		// xmlhttp.setRequestHeader("Content-type","application/json");
		// xmlhttp.send(data);

  //       console.log("Email: " + email + " Password: " + password);
}



function onAjaxSuccess(data, textStatus, jqXHR)
{
  // Здесь мы получаем данные, отправленные сервером и выводим их на экран.
  console.log("Data: " + data);
}

function onRequestError(jqXHR, textStatus, errorThrown ) {
	console.log("Error: " + textStatus + " ErrorThrown: " + errorThrown + " JQXHR: " + jqXHR);
}

// var jqxhr = $.post( "example.php", function() {
//   alert( "success" );
// })
//   .done(function() {
//     alert( "second success" );
//   })
//   .fail(function() {
//     alert( "error" );
//   })
//   .always(function() {
//     alert( "finished" );
// });