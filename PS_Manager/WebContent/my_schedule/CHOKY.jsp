<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%

int action = 0; //up(1) down(0)
int currYear = 0;
int currMonth = 0;
String boxSize = "70";

Calendar c = Calendar.getInstance();
Calendar cal = Calendar.getInstance();

if(request.getParameter("action") == null) {
    
     currMonth = c.get(Calendar.MONTH);
     currYear = c.get(Calendar.YEAR);
     cal.set(currYear,currMonth,1);
    
} else {
    
     if(request.getParameter("action") != null){
         
          currMonth = Integer.parseInt(request.getParameter("month"));
          currYear = Integer.parseInt(request.getParameter("year"));
         
          if(Integer.parseInt(request.getParameter("action"))==1) {

               cal.set(currYear, currMonth, 1);
               cal.add(Calendar.MONTH, 1); //다음달
               currMonth = cal.get(Calendar.MONTH);
               currYear = cal.get(Calendar.YEAR);
              
          } else {              

               cal.set(currYear, currMonth, 1);
               cal.add(Calendar.MONTH, -1); //이전달
               currMonth = cal.get(Calendar.MONTH);
               currYear = cal.get(Calendar.YEAR);         
          }
         
     }
}
System.out.println(currYear);
System.out.println(currMonth);
%>

<%!
     public boolean isDate(int y, int m, int d) {
    
          m -= 1;
          Calendar c = Calendar.getInstance();
          c.setLenient(false);
         
          try {
              
               c.set(y, m, d);
               Date dt = c.getTime();
              
          } catch(IllegalArgumentException e) {
               return false;
          }
          return true;
     }
%>

<%!
     public String getTitle(Calendar cal){
         
          SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월");
          return sdf.format(cal.getTime());    
     }

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 달력(Calendar)</title>
<style>
    
    #calendarTable, #calendarTable th, #calendarTable td   {
        border-collapse: collapse;
                    
    } 
    
    #calendarTable {
        border:2px solid #000;
        width:519px;
    }
    
    #calendarTable th, #calendarTable td {
        width: <%=boxSize%>px;
        border:1px solid #000;        
        border-collapse: collapse;
        padding: 5px;        
    }
    
    #calendarTable th {        
        background-color: #666;
        color: #fff;
        
    }    
    #calendarTable td {        
        height: <%=boxSize%>px;
        text-align : left;            
    }
    
    #calendarTable td.empty {
        background-color: #DFDCD8;
    }
    
    #calendarTable td.toDayColor {
        background-color: #6C7EAA;
    }
    
    
</style>
</head>
<body bgcolor='white'>
<table border='0' width='521' celpadding='0' cellspacing='0'>
  <tr>
     <td width='150' align='right' valign='middle'>
         <a href="CalendarExam.jsp?month=<%=currMonth%>&year=<%=currYear%>&action=0">
             <font size="2">이전달</font>
         </a>
     </td>
     <td width='260' align='center' valign='middle'>
         <b><%= getTitle(cal)%></b>
     </td>
     <td width='173' align='left' valign='middle'>
         <a href="CalendarExam.jsp?month=<%=currMonth%>&year=<%=currYear%>&action=1">
             <font size="2">다음달</font>
         </a>
    </td>
  </tr>
</table>
<table>
  <tr>         
  <td width="100%" >
    <table id="calendarTable">
       <tr>
              <th>일</th>
              <th>월</th>
              <th>화</th>
              <th>수</th>
              <th>목</th>
              <th>금</th>
              <th>토</th>                      
       </tr>
<%

//'Calendar loop


     int currDay;
     String todayColor;
     int count = 1;
     int dispDay = 1;


     for (int w = 1; w < 7; w++)
     {
%>
       <tr>
<%
          for (int d = 1; d < 8; d++)
          {
               if (!(count >= cal.get(Calendar.DAY_OF_WEEK))) //  
               {

%>
          <td class="empty">&nbsp;</td>
<%
                    count += 1;
               }
               else
               {

                    if (isDate (currYear, currMonth + 1,dispDay) ) // use the isDate method
                    {
                         //오늘
                         if (dispDay == c.get(Calendar.DAY_OF_MONTH) &&
                            c.get(Calendar.MONTH) == cal.get(Calendar.MONTH) 
                                && c.get(Calendar.YEAR) == cal.get(Calendar.YEAR) )
                         {
                             todayColor = "class='toDayColor'";
                         }
                         else
                         {
                             todayColor = "";
                         }
%>
          <td <%=todayColor%>><%=dispDay%><br>
          </td><%
                         count += 1;
                         dispDay += 1;
                    }
                    else
                    {
%>
          <td class="empty">&nbsp;</td>
<%
                    }
               }
       }
%>
       </tr>
<%
}
%>
     </table>
     </td>
     </tr>
  </table>
</body>
</html>