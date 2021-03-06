<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="helloJsp.object.ShoppingCart"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.IOException" %>
<%@page import= "org.apache.http.HttpResponse"%>
<%@page import= "org.apache.http.client.ClientProtocolException"%>
<%@page import= "org.apache.http.client.HttpClient"%>
<%@page import= "org.apache.http.client.methods.HttpGet"%>
<%@page import= "org.apache.http.client.methods.HttpPost"%>
<%@page import= "org.apache.http.entity.mime.MultipartEntity"%>
<%@page import= "org.apache.http.entity.mime.content.StringBody"%>
<%@page import= "org.apache.http.impl.client.DefaultHttpClient"%>
<%@page import= "java.net.HttpURLConnection"%>
<%@page import= "java.net.URL" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="public/css/style.css">
<title>Chintalian &#9733 &#9733 &#9733 &#9733 &#9733 dinner italian cuisine</title>
</head>
<body class="container">
	<%@ page import="java.util.ArrayList"%>
	<%@ page import="helloJsp.model.ModelInventori"%>
	<%@ page import="org.json.JSONObject"%>
	<%@ page import="org.json.JSONArray"%>
	<%
		ArrayList<ModelInventori> TabelBarang = new ArrayList<ModelInventori>();
	%>
	<%@include file="templates/header.jsp"%>

		<!--  <div class="content">
			<button onClick=""><<</button>
			<div id="contents">
				<img src="public/img/logo.png" width="300">
			</div>
			<div id="contents">
				<img src="public/img/logo.png" width="300">
			</div>
			<div id="contents">
				<img src="public/img/logo.png" width="300">
			</div>
			<div id="contents"><button>>></button></div>
		</div>-->
	
	</div>
	
	<div class="leftbar">
		<h2>HOW TO BUY?</h2>
		<p>It's easy!</p>
		<p>1. Don't forget to register and create your account</p>
		<p>2. Find an item</p>
		<p>3. Pick the quantity and click the button</p>
		<p>4. Go to cart</p>
		<p>5. Buy!</p>
		
		<h2>MOST FAVOURITE MENU</h2>
	<%
	//HttpURLConnectionExample http = new HttpURLConnectionExample();

	String url = "http://wbd3.ap01.aws.af.cm/favorit";
	 
	URL obj = new URL(url);
	HttpURLConnection con = (HttpURLConnection) obj.openConnection();

	// optional default is GET
	con.setRequestMethod("GET");

	//add request header
	con.setRequestProperty("User-Agent", "Mozilla/5.0");

	int responseCode = con.getResponseCode();
	System.out.println("\nSending 'GET' request to URL : " + url);
	System.out.println("Response Code : " + responseCode);

	BufferedReader in = new BufferedReader(
	        new InputStreamReader(con.getInputStream()));
	String inputLine;
	StringBuffer sresponse = new StringBuffer();

	while ((inputLine = in.readLine()) != null) {
		sresponse.append(inputLine);
	}
	in.close();

	JSONObject jobj = new JSONObject(sresponse.toString());
	System.out.println("json :"+jobj.toString());
	JSONArray jarr = jobj.getJSONArray("favorit");
	System.out.println("jarr :"+jarr.toString().substring(1, jarr.toString().length()-1));
	JSONArray j2 = new JSONArray(jarr.toString().substring(1, jarr.toString().length()-1));
	TabelBarang = new ArrayList<ModelInventori>();
	for (int i=0; i<j2.length(); i++){
		JSONObject json = j2.getJSONObject(i);
		ModelInventori barang = new ModelInventori();
		barang.setNama_inventori(json.getString("nama_inventori"));
		barang.setId_inventori(json.getInt("id_inventori"));
		barang.setId_kategori(json.getInt("id_kategori"));
		barang.setJumlah(json.getInt("jumlah"));
		barang.setHarga(json.getInt("harga"));
		barang.setGambar(json.getString("gambar"));
		barang.setDescription(json.getString("description"));
		TabelBarang.add(barang);
	}
	session.removeAttribute("favorit");
	session.setAttribute("favorit", TabelBarang);
	session.removeAttribute("tabel");
	session.setAttribute("tabel", TabelBarang);	

	if (session.getAttribute("favorit") != null){
		out.println("<h2>APPETIZER</h2>");
		int j = 0;
		for (int i=0; i<TabelBarang.size(); i++){
			if (TabelBarang.get(i).getId_kategori() == 1){
				out.println("<div class=\"barang\">");
				out.println("<img width=100px height=100px src=public/img/appetizer/" + TabelBarang.get(i).getGambar() + " alt=" + TabelBarang.get(i).getNama_inventori() + " width = 150 height=300>");
				out.println("<br/><a href='detailBarang.jsp?idBarang="+(TabelBarang.get(i).getId_inventori())+"'>"+TabelBarang.get(i).getNama_inventori() + "</a><br>");
				out.println("</div>");
				j++;
				if (j == 3) break;
			}
		}
		out.println("<h2>PIZZA</h2>");
		j = 0;
		for (int i=0; i<TabelBarang.size(); i++){
			if (TabelBarang.get(i).getId_kategori() == 2){
				out.println("<div class=\"barang\">");
				out.println("<img width=100px height=100px src=public/img/pizza/" + TabelBarang.get(i).getGambar() + " alt=" + TabelBarang.get(i).getNama_inventori() + " width = 150 height=300>");
				out.println("<br/><a href='detailBarang.jsp?idBarang="+(TabelBarang.get(i).getId_inventori())+"'>"+TabelBarang.get(i).getNama_inventori() + "</a><br>");
				out.println("</div>");
				j++;
				if (j == 3) break;
			}
		}
		out.println("<h2>PASTA</h2>");
		j = 0;
		for (int i=0; i<TabelBarang.size(); i++){
			if (TabelBarang.get(i).getId_kategori() == 3){
				out.println("<div class=\"barang\">");
				out.println("<img width=100px height=100px src=public/img/pasta/" + TabelBarang.get(i).getGambar() + " alt=" + TabelBarang.get(i).getNama_inventori() + " width = 150 height=300>");
				out.println("<br/><a href='detailBarang.jsp?idBarang="+(TabelBarang.get(i).getId_inventori())+"'>"+TabelBarang.get(i).getNama_inventori() + "</a><br>");
				out.println("</div>");
				j++;
				if (j == 3) break;
			}
		}
		out.println("<h2>DESSERTS</h2>");
		j = 0;
		for (int i=0; i<TabelBarang.size(); i++){
			if (TabelBarang.get(i).getId_kategori() == 4){
				out.println("<div class=\"barang\">");
				out.println("<img width=100px height=100px src=public/img/desserts/" + TabelBarang.get(i).getGambar() + " alt=" + TabelBarang.get(i).getNama_inventori() + " width = 150 height=300>");
				out.println("<br/><a href='detailBarang.jsp?idBarang="+(TabelBarang.get(i).getId_inventori())+"'>"+TabelBarang.get(i).getNama_inventori() + "</a><br>");
				out.println("</div>");
				j++;
				if (j == 3) break;
			}
		}
		out.println("<h2>BEVERAGES</h2>");
		j = 0;
		for (int i=0; i<TabelBarang.size(); i++){
			if (TabelBarang.get(i).getId_kategori() == 5){
				out.println("<div class=\"barang\">");
				out.println("<img width=100px height=100px src=public/img/beverages/" + TabelBarang.get(i).getGambar() + " alt=" + TabelBarang.get(i).getNama_inventori() + " width = 150 height=300>");
				out.println("<br/><a href='detailBarang.jsp?idBarang="+(TabelBarang.get(i).getId_inventori())+"'>"+TabelBarang.get(i).getNama_inventori() + "</a><br>");
				out.println("</div>");
				j++;
				if (j == 3) break;
			}
		}
	} else {
		//response.sendRedirect("Favorit");
	}
	%>
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

	<div id="starter">
		<img class="animation" src="public/img/logo.png" width=500>
		<h2 class="text_animation">&#9733 &#9733 &#9733 &#9733 &#9733 dinner italian cuisine</h2>
	</div>
	
	<script>
		<% String message = request.getParameter("msg");
		if (message != null){
		%>
		alert(<%=message%>);
		<% } %>
	</script>
	
	<script>
        function outputResult()
        {
            var response = invocation.responseText;
            var textDiv = document.getElementById("textDiv");
            textDiv.innerHTML += response;
        }

	
		function fadein(){
			//---- WELCOME PROCESS ----\\
				var n = 0;
				var m = 1;
				// WELCOME FADE IN
				for (x=0;x<=20;x++){
					setTimeout(function(){
						document.getElementById('starter').style.opacity = 0.05*n;
						n++;
					}, ((50*(m+1))));
				m++;
				}
				
				// WELCOME FADE OUT
				m=0;
				for (x=0;x<=21;x++){
					setTimeout(function(){
						if(x>11) document.getElementById('starter').style.display="none";
						document.getElementById('starter').style.opacity = (0.05*n);
						n--;
					}, (3000+(50*(m+1))));
					m++;
				}
				
		}
		
		function transition(link){
			var n = 10;
			var m = 1;
			// CONTENT FADE OUT
			for (x=0;x<=10;x++){
				setTimeout(function(){
					document.getElementById('content_frame').style.opacity = 0.1*n;
					n--;
				}, (50*(m+1)));
			m++;
			}
			// LOGO FADE IN
			var o = 0;
			var p = 1;
			for (x=0;x<=10;x++){
				setTimeout(function(){
					document.getElementById('trans').style.opacity = (0.1*p);
					p++;
				}, (300+(50*(o+1))));
				o++;
			}
			//CHANGE LINK
				setTimeout(function(){
					document.getElementById('content_frame').src=link;
				}, 2000);
		}
	</script>
	<script>fadein();</script>
</body>
</html>
