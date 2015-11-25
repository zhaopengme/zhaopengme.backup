title: webservice中的xml文件的交互
id: 393
categories: java
date: 2009-07-06 13:16:45
tags:
---

　　使用webservice中使用的类型可以是好多种，string、element、document等等甚至可以使对象！
</br>　　我使用element来传输xml文件，写了一个文件，源码如下
</br><pre>
import java.io.Reader;
import java.io.StringReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.apache.xpath.XPathAPI;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.xml.sax.InputSource;
/**
 * 工单查询接口 boos提供serialNumber、serviceNum输入参数
 *
 * @author joypen
 *
 */
public class WidebandBusinessQueryService {
	// 提供的查询方法
	public Element queryWideband(Element requestXml) throws Exception {
		Map map = this.databaseMethod(requestXml);
		String responseXml = this.dealResponseXml(map);
		System.out.println(&quot;111 &quot;+responseXml);
        Document doc = null;
            Reader strreader=new StringReader(responseXml);
            DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
            doc = builder.parse(new InputSource(strreader));
		return  doc.getDocumentElement();
	}
	// 连接数据库，并且执行sql语句
	private Map databaseMethod(Element requestXml) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Map map = null;
		String serialNumber = null;
		String serviceNum = null;
		try {
			map = this.parseXml(requestXml);
			serialNumber = (String) map.get(&quot;SERIALNUMBER&quot;);
			serviceNum = (String) map.get(&quot;SERVICENUM&quot;);
			if(TextUtil.isNull(serialNumber) || &quot;&quot;.equals(serialNumber) || TextUtil.isNull(serviceNum) || &quot;&quot;.equals(serviceNum)){
				map.put(&quot;ERRORCODE&quot;, &quot;1&quot;);
				map.put(&quot;DESCRIPTION&quot;, &quot;SERIALNUMBER OR SERVICENUM IS WORING!&quot;);
			}else{
				conn = Helper.getDBCnn();
				conn.setAutoCommit(false);
				String sqlString = this.sqlQueryString(serialNumber, serviceNum);
				ps = conn.prepareStatement(sqlString);
				rs = ps.executeQuery();
				map = this.dealResult(rs);
			}
		} catch (Exception e) {
			System.out.print(&quot;WidebandBusinessQueryService--数据库连接出错！&quot;);
			e.printStackTrace();
		}finally{
			try {
				rs = null;
				ps = null;
				if(conn!=null){
					conn.setAutoCommit(true);
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return map;
	}
	// 拼接sql语句
	private String sqlQueryString(String serialNumber, String serviceNum) {
		StringBuffer sql = new StringBuffer();
		sql.append(&quot;select * from t_pbb_open_main where SERIALNUMBER = +serialNumber+ and SERVICE_NUM = +serviceNum+ &quot;);
		return sql.toString();
	}
	// 处理返回的结果集
	private Map dealResult(ResultSet rs) {
		HashMap map = null;
		try {
			map = new HashMap();
			if(rs.next()){
				map.put(&quot;ERRORCODE&quot;, &quot;0&quot;);
				map.put(&quot;SERIALNUMBER&quot;, rs.getString(&quot;SERIALNUMBER&quot;));
				map.put(&quot;SERVICENUM&quot;, rs.getString(&quot;SERVICE_NUM&quot;));
				map.put(&quot;FORMNO&quot;, rs.getString(&quot;FORM_NO&quot;));
				map.put(&quot;STATE&quot;, rs.getString(&quot;PROCESS_STATE&quot;));
				map.put(&quot;OPERATORNAME&quot;, rs.getString(&quot;SERVICE_NUM&quot;));
			}else{
				map.put(&quot;ERRORCODE&quot;, &quot;1&quot;);
				map.put(&quot;DESCRIPTION&quot;, &quot;WITHOUT THIS RECORD!&quot;);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return map;
	}
	// 解析xml，得到serialNumber和serviceNum
	private Map parseXml(Element requestXml) throws Exception {
		Map map = new HashMap();
			String serialNumber=&quot;&quot;;
			Node tmpNode = XPathAPI.selectSingleNode(requestXml, &quot;//SERIALNUMBER&quot;);
			if (tmpNode != null)
			{
				Node txtNode = tmpNode.getFirstChild();
				if (txtNode != null)
					serialNumber = txtNode.getNodeValue();
			}
			String serviceNum=&quot;&quot;;
			tmpNode = XPathAPI.selectSingleNode(requestXml, &quot;//SERVICENUM&quot;);
			if (tmpNode != null)
			{
				Node txtNode = tmpNode.getFirstChild();
				if (txtNode != null)
					serviceNum = txtNode.getNodeValue();
			}
			map.put(&quot;SERIALNUMBER&quot;, serialNumber);
			map.put(&quot;SERVICENUM&quot;, serviceNum);
		return map;
	}
	// 拼接responseXml
	private String dealResponseXml(Map responseMap) {
		String resultCode = (String) (TextUtil.isNull(responseMap.get(&quot;ERRORCODE&quot;)) ? &quot;&quot; : responseMap.get(&quot;ERRORCODE&quot;));
		String serialNumber = (String) (TextUtil.isNull(responseMap.get(&quot;SERIALNUMBER&quot;)) ? &quot;&quot; : responseMap.get(&quot;SERIALNUMBER&quot;));
		String serviceNum = (String) (TextUtil.isNull(responseMap.get(&quot;SERVICENUM&quot;)) ? &quot;&quot; : responseMap.get(&quot;SERVICENUM&quot;));
		String formNo = (String) (TextUtil.isNull(responseMap.get(&quot;FORMNO&quot;)) ? &quot;&quot; : responseMap.get(&quot;FORMNO&quot;));
		String description = (String) (TextUtil.isNull(responseMap.get(&quot;DESCRIPTION&quot;)) ? &quot;&quot; : responseMap.get(&quot;DESCRIPTION&quot;));
		String time = (String) (TextUtil.isNull(responseMap.get(&quot;time&quot;)) ? &quot;&quot; : responseMap.get(&quot;time&quot;));
		String state = (String) (TextUtil.isNull(responseMap.get(&quot;STATE&quot;)) ? &quot;&quot; : responseMap.get(&quot;STATE&quot;));
		String operatorName = (String) (TextUtil.isNull(responseMap.get(&quot;OPERATORNAME&quot;)) ? &quot;&quot; : responseMap.get(&quot;OPERATORNAME&quot;));
		String operatorPhone = (String) (TextUtil.isNull(responseMap.get(&quot;OPERATORPHONE&quot;)) ? &quot;&quot; : responseMap.get(&quot;OPERATORPHONE&quot;));
		StringBuffer sb = new StringBuffer();
		sb.append(&quot;
&quot;);
		sb.append(&quot;
&quot;);
			sb.append(&quot;&quot;+resultCode+&quot;
&quot;);
			sb.append(&quot;&quot;+serialNumber+&quot;
&quot;);
			sb.append(&quot;&quot;+serviceNum+&quot;
&quot;);
			sb.append(&quot;&quot;+formNo+&quot;
&quot;);
			sb.append(&quot;响应时间
&quot;);
			sb.append(&quot;失败原因
&quot;);
				sb.append(&quot;
&quot;);
					sb.append(&quot;当前环节
&quot;);
					sb.append(&quot;操作人姓名
&quot;);
					sb.append(&quot;操作人电话
&quot;);
				sb.append(&quot;
&quot;);
		sb.append(&quot;
&quot;);
		return sb.toString();
	}
	public static void main(String[] args) throws Exception {
		String reqeustXml = &quot;321312陶宏辉请求时间&quot;;
		Document doc = null;
        Reader strreader=new StringReader(reqeustXml);
        DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
        doc = builder.parse(new InputSource(strreader));
		Element responseXml = new WidebandBusinessQueryService().queryWideband(doc.getDocumentElement());
		String testXml = &quot;&quot;;
		Node tempNode = XPathAPI.selectSingleNode(responseXml, &quot;//OPERATORNAME&quot;);
		if(tempNode!=null){
			Node txtNode = tempNode.getFirstChild();
			if(txtNode!=null){
				testXml = txtNode.getTextContent();
			}
		}
		System.out.println(&quot;reqeust: &quot;+reqeustXml);
		System.out.println(&quot;testXml: &quot;+testXml);
	}
}
</pre>
