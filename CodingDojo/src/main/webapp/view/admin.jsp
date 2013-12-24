<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;">
    <title>Admin page</title>
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/dojo.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/resources/js/jquery-1.7.2.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jquery.validate.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/validation.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/admin.js"></script>
</head>
<body>
    <div class="page-header">
        <h1>Admin page</h1>
    </div>
    <form:form commandName="adminSettings" action="admin31415" method="POST">
        <table class="admin-table" id="selectGame">
            <tr>
                <td>
                    <c:forEach items="${games}" var="game" varStatus="status">
                        <a href="${pageContext.request.contextPath}/admin31415?game=${game}">${game}</a>
                    </c:forEach>
                </td>
            </tr>
        </table>

        <table class="admin-table" id="pauseGame">
            <tr>
                <td>
                    <c:choose>
                        <c:when test="${paused}">
                            <b>The dojo was suspended</b></br> <a href="${pageContext.request.contextPath}/admin31415?resume">Resume game</a>.
                        </c:when>
                        <c:otherwise>
                            <b>The dojo is active</b></br> <a href="${pageContext.request.contextPath}/admin31415?pause">Pause game</a>.
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </table>

        <table class="admin-table" id="cleanGame">
            <tr>
                <td>
                    <a href="${pageContext.request.contextPath}/admin31415?cleanAll">Clean all scores</a>.
                </td>
            </tr>
        </table>

        <table class="admin-table" id="gameSettings">
            <tr colspan="2">
                <td><b>Game settings</b></td>
            </tr>
            <tr>
                <td class="header">Parameter name</td>
                <td class="header">Value</td>
            </tr>
            <c:forEach items="${parameters}" var="parameter" varStatus="status">
                <tr>
                    <td>${parameter.name}</td>
                    <td><form:input path="parameters[${status.index}]"/></td>
                </tr>
            </c:forEach>
        </table>


        <c:if test="${players != null || savedGames != null}">
            <table class="admin-table" id="savePlayersGame">
                <tr colspan="3">
                    <td><b>Registered Players</b></td>
                </tr>
                <tr>
                    <td class="header">Player name</td>
                    <td class="header">URL</td>
                </tr>
                <c:forEach items="${players}" var="player" varStatus="status">
                    <c:choose>
                        <c:when test="${player.active}">
                            <tr>
                                <td><form:input path="players[${status.index}].name"/></td>
                                <td><form:input path="players[${status.index}].callbackUrl"/></td>
                                <td><a href="${pageContext.request.contextPath}/admin31415?save=${player.name}">Save</a></td>
                                <c:choose>
                                    <c:when test="${player.saved}">
                                        <td><a href="${pageContext.request.contextPath}/admin31415?load=${player.name}">Load</a></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>Load</td>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${player.saved}">
                                        <td><a href="${pageContext.request.contextPath}/admin31415?removeSave=${player.name}">RemoveSave</a></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>RemoveSave</td>
                                    </c:otherwise>
                                </c:choose>
                                <td><a href="${pageContext.request.contextPath}/admin31415?gameOver=${player.name}">GameOver</a></td>
                                <td><a href="${pageContext.request.contextPath}/board/${player.name}?code=${player.code}">ViewGame</a></td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td><input class="uneditable-input" value="${player.name}"/></td>
                                <td><input class="uneditable-input" value="${player.callbackUrl}"/></td>
                                <td>Save</td>
                                <c:choose>
                                    <c:when test="${player.saved}">
                                        <td><a href="${pageContext.request.contextPath}/admin31415?load=${player.name}">Load</a></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>Load</td>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${player.saved}">
                                        <td><a href="${pageContext.request.contextPath}/admin31415?removeSave=${player.name}">RemoveSave</a></td>
                                    </c:when>
                                    <c:otherwise>
                                        <td>RemoveSave</td>
                                    </c:otherwise>
                                </c:choose>
                                <td>GameOver</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <tr>
                    <td></td>
                    <td></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin31415?saveAll">SaveAll</a>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin31415?loadAll">LoadAll</a>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin31415?removeSaveAll">RemoveSaveAll</a>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/admin31415?gameOverAll">GameOverAll</a>
                    </td>
                </tr>
            </table>
            <input type="submit" value="Save"/>
            </br>
        </c:if>

        </br>
        Go to <a href="${pageContext.request.contextPath}/">main page</a>.
    </form:form>
</body>
</html>