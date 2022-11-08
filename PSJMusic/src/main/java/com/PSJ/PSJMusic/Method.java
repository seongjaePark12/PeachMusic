package com.PSJ.PSJMusic;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

import com.PSJ.PSJMusic.music.ChartVO;

public class Method {
	public String getImgSize(String img, String size) {
		String img_ = img.replaceFirst("50", size);
		return img_;
	}
	
	public boolean isFile(String title, String artist) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String name = title + " - " + artist + ".mp3";
		name = name.replaceAll("[\\\\/:*?\"<>|]", "");
		String path = request.getSession().getServletContext().getRealPath("/resources/music/");
		File f = new File(path + name);
		if (f.exists()) return true;
		return false;
	}
	
	public void ckUpload(HttpServletRequest req, HttpServletResponse res, @RequestParam MultipartFile upload) {
		// 랜덤 문자 생성
		 UUID uid = UUID.randomUUID();
		 
		 OutputStream out = null;
		 PrintWriter printWriter = null;
		   
		 // 인코딩
		 res.setCharacterEncoding("utf-8");
		 res.setContentType("text/html;charset=utf-8");
		 
		 try {
		  
		  String fileName = upload.getOriginalFilename();  // 파일 이름 가져오기
		  byte[] bytes = upload.getBytes();
		  
		  // 업로드 경로
		  String uploadPath = req.getSession().getServletContext().getRealPath("/resources/img/");
		  String ckUploadPath = uploadPath + File.separator + "ckUpload" + File.separator + uid + "_" + fileName;
		  
		  out = new FileOutputStream(new File(ckUploadPath));
		  out.write(bytes);
		  out.flush();  // out에 저장된 데이터를 전송하고 초기화
		  
		  printWriter = res.getWriter();
		  String fileUrl = req.getContextPath() + "/resources/img/ckUpload/" + uid + "_" + fileName;  // 작성화면

		  // 업로드시 메시지 출력
		  JsonObject json = new JsonObject();
		  json.addProperty("uploaded", 1);
		  json.addProperty("fileName", fileName);
		  json.addProperty("url", fileUrl);
		  
		  printWriter.println(json);		  
	 		  
	 
		 } catch (IOException e) { e.printStackTrace();
		 } finally {
		  try {
		   if(out != null) { out.close(); }
		   if(printWriter != null) { printWriter.close(); }
		  } catch(IOException e) { e.printStackTrace(); }
		 }
	}
	
	public List<ChartVO> getChartTop100() throws IOException {
		String url = "https://music.bugs.co.kr/chart/track/day/total";
		Document data = Jsoup.connect(url).get();
		
		Elements imgs = data.select(".list>tbody>tr");
		Elements titles = data.select("p.title");
		Elements artists = data.select("p.artist");
		Elements ranks = data.select("div.ranking > strong");
		
		List<String> imgList = new ArrayList<String>();
		List<String> titleList = new ArrayList<String>();
		List<String> artistList = new ArrayList<String>();
		List<String> rankList = new ArrayList<String>();
		
		List<ChartVO> vos = new ArrayList<ChartVO>();
		
		for (int i=0; i<100; i++) {
			imgList.add(imgs.get(i).select("a>img").get(0).attr("src"));
			titleList.add(titles.get(i).text());
			
			if (artists.get(i).select(".artistTitle").text().equals("")) artistList.add(artists.get(i).text());
			else artistList.add(artists.get(i).select(".artistTitle").text());
			
			rankList.add(ranks.get(i).text());
		}
		
		for (int i=0; i<100; i++) {
			ChartVO vo = new ChartVO();
			vo.setSJ_CHART_IMG(imgList.get(i));
			vo.setSJ_CHART_TITLE(titleList.get(i));
			vo.setSJ_CHART_ARTIST(artistList.get(i));
			vo.setSJ_CHART_RANK(Integer.parseInt(rankList.get(i)));
			System.out.println(vo);
			vos.add(vo);
		}
		
		return vos;
	}
	
}
