<%@page import="org.json.JSONObject"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="helloJsp.object.ShoppingCart"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import= "java.net.HttpURLConnection"%>
<%@page import= "java.net.URL"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import= "java.io.DataOutputStream"%>
<%@page import ="java.io.InputStreamReader"%>
<%@page import ="java.net.HttpURLConnection"%>
<%@page import="javax.net.ssl.HttpsURLConnection"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="public/css/style.css">
<script type="text/javascript" src="public/js/cart.js"></script>
<title>Chintalian &#9733 &#9733 &#9733 &#9733 &#9733 dinner italian cuisine</title>
</head>
<body class="container" alink=#000000 vlink=#000000>
	<%@ page import="java.util.ArrayList"%>
	<%@ page import="helloJsp.model.ModelInventori"%>
	<%@include file="templates/header.jsp"%>

	<%
	JSONObject JOB = null;
	//	koneksi dulu ke
	System.out.println("test ya");
	if (session.getAttribute("user") == null) {
		System.out.println("redirect :v");
		String forward = "/registrasi.jsp";
		//response.sendRedirect(forward);
		%>
		 <jsp:forward page="/registrasi.jsp"/>
		<%	//RequestDispatcher dispatch = getServletContext().getRequestDispatcher(forward);
			//dispatch.forward(request, response);
		} else {
			System.out.println("session user : "+session.getAttribute("user"));
			if (session.getAttribute("user").toString().length()<1)
				response.sendRedirect("registrasi.jsp");
			System.out.println("session user : "+session.getAttribute("user"));
			//JSONObject JOB = new JSONObject();
			//JOB.append("session", request.getSession());
			String url = "https://wbd3.ap01.aws.af.cm/profile";
			URL obj = new URL(url);
			HttpsURLConnection con = (HttpsURLConnection) obj.openConnection();
			 String USER_AGENT = "Mozilla/5.0";
			//add reuqest header
			con.setRequestMethod("POST");
			con.setRequestProperty("User-Agent", USER_AGENT);
			con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");

			String urlParameters = "user="+session.getAttribute("user");

			// Send post request
			con.setDoOutput(true);
			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			wr.writeBytes(urlParameters);
			wr.flush();
			wr.close();

			int responseCode = con.getResponseCode();
			System.out.println("\nSending 'POST' request to URL : " + url);
			System.out.println("Post parameters : " + urlParameters);
			System.out.println("Response Code : " + responseCode);

			BufferedReader in = new BufferedReader(
			        new InputStreamReader(con.getInputStream()));
			String inputLine;
			StringBuffer responses = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				responses.append(inputLine);
			}
			inputLine =responses.toString();
			System.out.println("this is response :"+inputLine);
			in.close();
			JOB = new JSONObject(inputLine);
			
			
		}	
	
		ArrayList<ModelInventori> TabelBarang = new ArrayList<ModelInventori>();
			TabelBarang = (ArrayList<ModelInventori>) session.getAttribute("tabel");
	%>

	<div class="leftbar">
		<h2>VIEW PROFILE</h2>
		<div id="info"></div>
		<span id="foto"><img src='public/img/minion.jpg' width=300px></span>
		<span id="heads"></span>
		<pre id="nama">Nama Lengkap 		:<span id="sname"><%out.print(JOB.get("nama_pengguna").toString().substring(2,JOB.get("nama_pengguna").toString().length()-2 ));%></span>
		</pre>
		<pre id="usernamep">Username		:<span id="suser"><%out.print(JOB.get("username").toString().substring(2,JOB.get("username").toString().length()-2 )); %></span>
		</pre>
		<pre id="pass">Password		:<span id="spassword"><%out.print(JOB.get("password").toString().substring(2,JOB.get("password").toString().length()-2 )); %></span>
		</pre>
		<pre id="nomorhp">Nomor Hp		:<span id="snohp"><%out.print(JOB.get("nomor_hp").toString().substring(2,JOB.get("nomor_hp").toString().length()-2 )); %></span>
		</pre>
		<pre id="alamat">Alamat			:<span id="salamat"><%out.print(JOB.get("alamat").toString().substring(2,JOB.get("alamat").toString().length()-2 )); %></span>
		</pre>
		<pre id="provinsi">Provinsi		:<span id="sprovinsi"><%out.print(JOB.get("provinsi").toString().substring(2,JOB.get("provinsi").toString().length()-2 )); %></span>
		</pre>
		<pre id="kota">Kota/Kabupaten		:<span id="skota"><%out.print(JOB.get("kota_kabupaten").toString().substring(2,JOB.get("kota_kabupaten").toString().length()-2 )); %></span>
		</pre>
		<pre id="kodepos">Kode Pos		:<span id="skodepos"><%out.print(JOB.get("kode_pos").toString().substring(2,JOB.get("kode_pos").toString().length()-2 )); %></span>
		</pre>
		<pre id="email">Email			:<span id="semail"><%out.print(JOB.get("email").toString().substring(2,JOB.get("email").toString().length()-2 )); %></span>
		</pre>
		<pre id="transaction">Total transaction	:<span id="stransaction"><%out.print(JOB.get("total_transaksi").toString().substring(2,JOB.get("total_transaksi").toString().length()-2 )); %></span>
		</pre>
		<span id="edits"><button id="editprof"
				onClick="editprofile(<%out.print(JOB.get("username").toString().substring(2,JOB.get("username").toString().length()-2 ));%>)">EDITPROF</button>
			<Button onClick="location.href='registerCardForm.jsp'">Daftarkan kartu kredit
				saya</button></span> <br /> <span id="tails"></span>
	</div>

	<div class="centerbar">
		<h2>YOUR CART</h2>
		<%
		
			int total = 0;
			if (session.getAttribute("shoppingCart") != null) {
				ShoppingCart sc = (ShoppingCart) session.getAttribute("shoppingCart");
				out.println("");
				for (int i = 0; i < sc.getItems().size(); i++) {
					int temp = 0;
					for (int j = 0; j < TabelBarang.size(); j++) {
						if(TabelBarang.get(j).getId_inventori() == sc.getItems().get(i).getIdItem()){
							temp = j;
							break;
						}
					}
					out.println("(" + (i + 1) + ") " + sc.getItems().get(i).getQuantity() + "x " + TabelBarang.get(temp).getNama_inventori()+ " Rp. "+sc.getItems().get(i).getQuantity()*sc.getItems().get(i).getPrice() +",- <button>delete</button><br/>");
					
					if(sc.getItems().get(i).getDescription().equals("")){
						out.println("No special order<br/>");
					} else
						out.println("Special order : " + sc.getItems().get(i).getDescription());
					
					total += sc.getItems().get(i).getQuantity()*sc.getItems().get(i).getPrice();
				}
			}
			out.println("<br/><b>Total price: Rp. " + total+",-</b>");
		%>
	</div>
	<%@include file="templates/footer.jsp"%>
	<script>
		function RCF(){
			alert("RCF ni :v");
			location="registerCardForm.jsp"; 
		}
		function validate(text, num, pas) {
			var xmlhttp;
			var validpic = '<img src="public/img/like.png" width="15" height="15"/>';
			var invalidpic = '<img src="public/img/unlike.png" width="15" height="15"/>';
			var wait = '<img src="public/img/ajaxLoader.gif" width="15" height="15"/>';
			var valid = false;
			var temp = "" + text;
			if (temp.length == 0) {
				if (num == 1)
					document.getElementById("validasiNama2").innerHTML = "";
				else if (num == 3)
					document.getElementById("validasiPass2").innerHTML = "";
				else if (num == 5)
					document.getElementById("validasiEmail2").innerHTML = "";
				return;
			}
			if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					//readysubmit(num,xmlhttp.responseText);
					alert(xmlhttp.responseText);
					switch (num) {
					case 1:
						switch (xmlhttp.responseText) {
						case '0':
							document.getElementById("validasiNama2").innerHTML = validpic;
							break;
						default:
							document.getElementById("validasiNama2").innerHTML = invalidpic
									+ " (Nama harus terdiri dari karakter(A-Z)(a-z). Minimal 2 kata.)";
							break;
						}
						break;
					case 3:
						switch (xmlhttp.responseText) {
						case '0':
							document.getElementById("validasiPass2").innerHTML = validpic;
							break;
						case '1':
							document.getElementById("validasiPass2").innerHTML = invalidpic
									+ " (Password tidak boleh sama dengan username)";
							break;
						case '2':
							document.getElementById("validasiPass2").innerHTML = invalidpic
									+ " (Password minimal 8 karakter)";
							break;
						}
						break;
					case 5:
						switch (xmlhttp.responseText) {
						case '0':
							document.getElementById("validasiEmail2").innerHTML = validpic;
							break;
						case '1':
							document.getElementById("validasiEmail2").innerHTML = invalidpic
									+ " (Invalid Email)";
							break;
						}
						break;
					}
				} else {
					switch (num) {
					case 1:
						document.getElementById("validasiNama2").innerHTML = wait;
						break;
					case 3:
						document.getElementById("validasiPass2").innerHTML = wait;
						break;
					case 5:
						document.getElementById("validasiEmail2").innerHTML = wait;
						break;
					}
				}
			}
			xmlhttp.open("GET", "Validasi?q=" + temp + "&num=" + num + "&pass="
					+ pas, true);
			xmlhttp.send();
		}

		function updateprofile(nama, uname, pwd, email, nohp, alamat, provinsi,
				kota, kodepos) {
			var xmlhttp;
			if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					alert("Data :\n" + xmlhttp.responseText
							+ "tidak berubah. Data berhasil disimpan.");
					location.replace("index.jsp");
				}
			}
			xmlhttp.open("GET", "UpdateProfile?nama2=" + nama + "&uname="
					+ uname + "&pwd2=" + pwd + "&email2=" + email + "&nohp2="
					+ nohp + "&kodepos2=" + kodepos + "&kota2=" + kota
					+ "&provinsi2=" + provinsi + "&alamat2=" + alamat, true);
			xmlhttp.send();

		}

		function editprofile(temp) {
			//document.getElementById("heads").innerHTML="<form id='updateform' method='post' action='UpdateProfile'>";
			document.getElementById("sname").innerHTML = "<input name='nama2' value='<%out.print(JOB.get("nama_pengguna"));%>' type='text' id='nama2' onblur='validate(nama2.value,1,nohp2.value)'></input><span id='validasiNama2'></span>";
			document.getElementById("suser").innerHTML = "<input id='uname' value='<%out.print(JOB.get("username"));%>' readonly></input>";
			document.getElementById("spassword").innerHTML = "<input name='pwd2' type='password' value='<%out.print(JOB.get("password"));%>' id='pwd2' onblur='validate(pwd2.value,3,uname.value)'></input><span id='validasiPass2'></span>";
			document.getElementById("snohp").innerHTML = "<input name='nohp2' id='nohp2' value='<%out.print(JOB.get("nomor_hp"));%>'></input>";
			document.getElementById("salamat").innerHTML = "<input id='alamat2' name='alamat2' value='<%out.print(JOB.get("alamat"));%>'></input>";
			document.getElementById("sprovinsi").innerHTML = "<input id='provinsi2' name='provinsi2' value='<%out.print(JOB.get("provinsi"));%>'></input>";
			document.getElementById("skota").innerHTML = "<input id='kota2' name='kota2' value='<%out.print(JOB.get("kota_kabupaten"));%>'></input>";
			document.getElementById("skodepos").innerHTML = "<input id='kodepos2' name='kodepos2' value='<%out.print(JOB.get("kode_pos"));%>'>";
			document.getElementById("semail").innerHTML = "<input name='email2' value='<%out.print(JOB.get("email"));%>' id='email2' onblur='validate(email2.value,5,pwd2.value)'></input><span id='validasiEmail2'></span>";
			document.getElementById("edits").innerHTML = "<button onClick='updateprofile(nama2.value,uname.value,pwd2.value,email2.value,nohp2.value,alamat2.value,provinsi2.value,kota2.value,kodepos2.value)'>Save</button><a href='index.jsp'>Cancel</a>";
		}
		
		
	</script>
</body>
</html>