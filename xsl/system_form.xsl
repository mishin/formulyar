<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:exsl="http://exslt.org/common" xmlns:func="http://exslt.org/functions" extension-element-prefixes="func" xmlns:m8="http://m8data.com">
	<xsl:include href="get_name.xsl"/>
	<!--
-->
	<func:function name="m8:path">
		<xsl:param name="level1"/>
		<xsl:param name="level2"/>
		<xsl:param name="level3"/>
		<xsl:param name="level4"/>
		<xsl:choose>
			<xsl:when test="$level4">
				<func:result select="document( concat( $start/@planeRoot, 'm8/', substring( $level1, 1, 1 ), '/', $level1, '/', $level2, '/', $level3, '/', $level4, '.xml' ) )/*"/>
			</xsl:when>
			<xsl:when test="$level3">
				<func:result select="document( concat( $start/@planeRoot, 'm8/', substring( $level1, 1, 1 ), '/', $level1, '/', $level2, '/', $level1, '/', $level3, '.xml' ) )/*"/>
			</xsl:when>
			<xsl:when test="$level2">
				<func:result select="document( concat( $start/@planeRoot, 'm8/', substring( $level1, 1, 1 ), '/', $level1, '/', $level2, '.xml' ) )/*"/>
			</xsl:when>
			<xsl:when test="$level1">
				<func:result select="document( concat( $start/@planeRoot, 'm8/author/', $level1, '/type.xml' ) )/*"/>
			</xsl:when>
			<xsl:otherwise>
				<func:result select="document( concat( $start/@planeRoot, 'm8/n/n/', $author, '/n/port.xml' ) )/*"/>
			</xsl:otherwise>
		</xsl:choose>
	</func:function>
	<func:function name="m8:path_check">
		<xsl:param name="level1"/>
		<xsl:param name="level2"/>
		<xsl:param name="level3"/>
		<xsl:param name="level4"/>
		<xsl:choose>
			<xsl:when test="$level3">
				<xsl:variable name="role" select="m8:path( $level1, 'index' )/role/*"/>
				<xsl:choose>
					<xsl:when test="$level1 and $level2 and $level4 and $level3='*' and $role[@superfile=$level4] and m8:path( $level1, $role[@superfile=$level4]/@file )/*[name()=$level2]/*">
						<func:result select="document( concat( $start/@planeRoot, 'm8/', substring( $level1, 1, 1 ), '/', $level1, '/', $level2, '/', name(m8:path( $level1, $role[@superfile=$level4]/@file )/*[name()=$level2]/*), '/', $level4, '.xml' ) )/*"/>
					</xsl:when>
					<xsl:when test="$level1 and $level2 and $level4 and $role[@superfile=$level4] and m8:path( $level1, $role[@superfile=$level4]/@file )/*[name()=$level2]/*[name()=$level3]">
						<func:result select="document( concat( $start/@planeRoot, 'm8/', substring( $level1, 1, 1 ), '/', $level1, '/', $level2, '/', $level3, '/', $level4, '.xml' ) )/*"/>
					</xsl:when>
					<xsl:when test="$level1 and $level2 and not($level4) and $role[@superfile=$level3] and m8:path( $level1, $role[@superfile=$level3]/@file )/*[name()=$level2]/*[name()=$level1]">
						<func:result select="document( concat( $start/@planeRoot, 'm8/', substring( $level1, 1, 1 ), '/', $level1, '/', $level2, '/', $level1, '/', $level3, '.xml' ) )/*"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="nullElement">
							<xsl:choose>
								<xsl:when test="$level4">
									<xsl:element name="{$level4}"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:element name="{$level3}"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<func:result select="exsl:node-set($nullElement)/*"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$level2">
				<xsl:choose>
					<xsl:when test="$level1 and ( $level2='index' or $level2='value' or m8:path( $level1, 'index' )/*/*[@file=$level2] )">
						<func:result select="document( concat( $start/@planeRoot, 'm8/', substring( $level1, 1, 1 ), '/', $level1, '/', $level2, '.xml' ) )/*"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="nullElement">
							<xsl:element name="{$level2}"/>
						</xsl:variable>
						<func:result select="exsl:node-set($nullElement)/*"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="$level1">
				<func:result select="document( concat( $start/@planeRoot, 'm8/author/', $level1, '/type.xml' ) )/*"/>
			</xsl:when>
			<xsl:otherwise>
				<func:result select="document( concat( $start/@planeRoot, 'm8/n/n/', $author, '/n/port.xml' ) )/*"/>
			</xsl:otherwise>
		</xsl:choose>
	</func:function>
	<func:function name="m8:dir">
		<xsl:param name="level1"/>
		<xsl:param name="level2"/>
		<xsl:param name="level3"/>
		<xsl:choose>
			<xsl:when test="$level3">
				<func:result select="concat( 'm8/', substring( $level1, 1, 1 ), '/', $level1, '/', $level2, '/', $level3 )"/>
			</xsl:when>
			<xsl:when test="$level2">
				<func:result select="concat( 'm8/', substring( $level1, 1, 1 ), '/', $level1, '/', $level2, '/', $level1 )"/>
			</xsl:when>
			<xsl:when test="$level1">
				<func:result select="concat( 'm8/', substring( $level1, 1, 1 ), '/', $level1 )"/>
			</xsl:when>
			<xsl:otherwise>
				<func:result select="'m8'"/>
			</xsl:otherwise>
		</xsl:choose>
	</func:function>
	<!--

//-->
	<!--<xsl:variable name="da" select="ss"/>-->
	<!--
	информация по стартовому xml (здесь излишне читать порт, т.к. иногда он нужен)-->
	<xsl:variable name="authDir" select="'m8/author'"/>
	<xsl:variable name="start" select="/*"/>
	<!--<xsl:variable name="m8root" select="$start/@DOCUMENT_ROOT"/>-->
	<xsl:variable name="ctrl" select="$start/@ctrl"/>
	<xsl:variable name="fact" select="$start/@fact"/>
	<xsl:variable name="author" select="$start/@author"/>
	<xsl:variable name="avatar" select="$start/@avatar"/>
	<xsl:variable name="quest" select="$start/@quest"/>
	<xsl:variable name="xsStartID" select="m8:dir( $fact )"/>
	<xsl:variable name="sStartID" select="m8:dir( $fact, $author, $quest )"/>
	<xsl:variable name="startID" select="concat( $start/@prefix, 'a/', $ctrl, '/', $sStartID )"/>
	<xsl:variable name="startGroup" select="$start/@group"/>
	<xsl:variable name="user" select="$start/@user"/>
	<xsl:variable name="time" select="$start/@time"/>
	<xsl:variable name="adminMode" select="$start/@adminMode or $start/@debug"/>
	<xsl:variable name="localtime" select="$start/@localtime"/>
	<xsl:variable name="avatarTypeRoot" select="m8:path( $avatar )"/>
	<xsl:variable name="parent">
		<xsl:message>	--- parent --- </xsl:message>
		<xsl:call-template name="getParent">
			<xsl:with-param name="currentFactName" select="$fact"/>
			<xsl:with-param name="currentQuestName" select="$quest"/>
		</xsl:call-template>
	</xsl:variable>
	<xsl:variable name="rootName" select="name(exsl:node-set($parent)/*[3])"/>
	<xsl:variable name="parentName" select="name(exsl:node-set($parent)/*[last()])"/>
	<xsl:variable name="grandName" select="name(exsl:node-set($parent)/*[last()-1])"/>
	<xsl:variable name="factTypeName">
		<xsl:choose>
			<xsl:when test="$fact = 'n' ">i</xsl:when>
			<xsl:when test="starts-with($fact, 'n' )">
				<xsl:value-of select="name( m8:path( $fact, $author, $quest, 'port' )/r/* )"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="substring( $fact, 1, 1 )"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:message>	--- end variable set --- </xsl:message>
	</xsl:variable>
	<!--


	-->
	<xsl:template name="editParamOfPort">
		<xsl:param name="action"/>
		<xsl:param name="size"/>
		<xsl:param name="hidden"/>
		<xsl:param name="objectElement"/>
		<xsl:param name="inputType"/>
		<xsl:param name="questName"/>
		<xsl:param name="predicateName"/>
		<xsl:param name="sourceValue"/>
		<xsl:param name="sortSelect"/>
		<xsl:param name="titleSelect"/>
		<xsl:param name="ajaxMethod"/>
		<xsl:variable name="selectedValue" select="$objectElement/*[name()=$predicateName]/*"/>
		<xsl:if test="not($sourceValue)" xml:lang="только для текстовых инпутов для корректного отображения всплывающих сообщений">
			<xsl:attribute name="title"><xsl:choose xml:lang="2016-06-10: вносится наверх, а не в инпут т.к. при стилизации select2 сообщение нужно показывать не с инпута"><xsl:when test="$objectElement/@message"><xsl:value-of select="$objectElement/@message"/></xsl:when><xsl:otherwise><xsl:value-of select="$selectedValue/@message"/></xsl:otherwise></xsl:choose></xsl:attribute>
		</xsl:if>
		<form id="editParamOfPort" selectedValue="{name($selectedValue)}">
			<xsl:attribute name="action"><xsl:choose><xsl:when test="$action"><xsl:value-of select="$action"/></xsl:when><xsl:otherwise><xsl:value-of select="$startID"/></xsl:otherwise></xsl:choose>/</xsl:attribute>
			<xsl:if test="$predicateName = 'n' ">
				<xsl:attribute name="ENCTYPE">multipart/form-data</xsl:attribute>
				<xsl:attribute name="method">POST</xsl:attribute>
			</xsl:if>
			<xsl:if test="$ajaxMethod='load'">
				<input type="hidden" id="refreshYes"/>
			</xsl:if>
			<xsl:if test="$objectElement/@invalid or $selectedValue/@invalid">
				<input type="hidden" name="b1" value="{$rootName}"/>
				<input type="hidden" name="b2" value="{$shag}"/>
				<input type="hidden" name="b3" value="{$selectedValue/@invalid}{$objectElement/@invalid}"/>
				<input type="hidden" name="b5" value="{$rootName}"/>
			</xsl:if>
			<xsl:if test="$hidden">
				<xsl:for-each select="exsl:node-set($hidden)/*">
					<input type="hidden">
						<xsl:attribute name="name"><xsl:value-of select="name()"/></xsl:attribute>
						<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
					</input>
				</xsl:for-each>
			</xsl:if>
			<xsl:if test="$predicateName != 'n' ">
				<xsl:if test="$questName">
					<input type="hidden" name="quest" value="{$questName}"/>
				</xsl:if>
			</xsl:if>
			<xsl:call-template name="inputParamOfPortPre">
				<xsl:with-param name="inputType" select="$inputType"/>
				<xsl:with-param name="size" select="$size"/>
				<xsl:with-param name="questName" select="$questName"/>
				<xsl:with-param name="predicateName" select="$predicateName"/>
				<xsl:with-param name="selectedValue" select="$selectedValue"/>
				<xsl:with-param name="sourceValue" select="$sourceValue"/>
				<xsl:with-param name="sortSelect" select="$sortSelect"/>
				<xsl:with-param name="titleSelect" select="$titleSelect"/>
				<xsl:with-param name="ajaxMethod" select="$ajaxMethod"/>
			</xsl:call-template>
		</form>
	</xsl:template>
	<!--

	-->
	<xsl:template name="inputParamOfPortPre">
		<xsl:param name="inputType"/>
		<xsl:param name="size"/>
		<xsl:param name="questName"/>
		<xsl:param name="predicateName"/>
		<xsl:param name="selectedValue"/>
		<xsl:param name="sourceValue"/>
		<xsl:param name="sortSelect"/>
		<xsl:param name="titleSelect"/>
		<xsl:param name="option"/>
		<xsl:param name="ajaxMethod"/>
		<xsl:variable name="parentPredicateName" select="name( m8:path( $predicateName, 'subject_r' )/*/*[1] )"/>
		<xsl:choose>
			<xsl:when test="$sourceValue">
				<xsl:message>			Вывод параметра <xsl:value-of select="$predicateName"/> напрямую из входящего списка sourceValue</xsl:message>
				<xsl:call-template name="inputParamOfPort">
					<xsl:with-param name="inputType" select="$inputType"/>
					<xsl:with-param name="size" select="$size"/>
					<xsl:with-param name="questName" select="$questName"/>
					<xsl:with-param name="predicateName" select="$predicateName"/>
					<xsl:with-param name="selectedValue" select="$selectedValue"/>
					<xsl:with-param name="sourceValue" select="$sourceValue"/>
					<xsl:with-param name="sortSelect" select="$sortSelect"/>
					<xsl:with-param name="titleSelect" select="$titleSelect"/>
					<xsl:with-param name="ajaxMethod" select="$ajaxMethod"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="m8:path( $predicateName, $avatar, $parentPredicateName, 'port' )/n" xml:lang="вывод списка из tsv-файла">
				<xsl:message>			Вывод параметра <xsl:value-of select="$predicateName"/> списка из tsv-файла</xsl:message>
				<xsl:variable name="currentListName" select="name( m8:path( $predicateName, $avatar, $parentPredicateName, 'port' )/n/*)"/>
				<xsl:call-template name="inputParamOfPort">
					<xsl:with-param name="inputType" select="$inputType"/>
					<xsl:with-param name="size" select="$size"/>
					<xsl:with-param name="questName" select="$questName"/>
					<xsl:with-param name="predicateName" select="$predicateName"/>
					<xsl:with-param name="selectedValue" select="$selectedValue"/>
					<xsl:with-param name="sourceValue" select="m8:path( $currentListName, 'value' )"/>
					<xsl:with-param name="sortSelect" select="$sortSelect"/>
					<xsl:with-param name="titleSelect" select="$titleSelect"/>
					<xsl:with-param name="ajaxMethod" select="$ajaxMethod"/>
					<xsl:with-param name="option" select="$option"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$predicateName='r' and m8:path( $factTypeName, 'index' )/object" xml:lang="вывод экземпляров типа 2016-07-23">
				<xsl:message>			Вывод параметра 'r' списком экземпляров типа <xsl:value-of select="$factTypeName"/>
				</xsl:message>
				<xsl:call-template name="inputParamOfPort">
					<xsl:with-param name="inputType" select="$inputType"/>
					<xsl:with-param name="size" select="$size"/>
					<xsl:with-param name="questName" select="$questName"/>
					<xsl:with-param name="predicateName" select="$predicateName"/>
					<xsl:with-param name="selectedValue" select="$selectedValue"/>
					<xsl:with-param name="sourceValue" select="m8:path( $factTypeName, 'index' )/object"/>
					<xsl:with-param name="sortSelect" select="$sortSelect"/>
					<xsl:with-param name="titleSelect" select="$titleSelect"/>
					<xsl:with-param name="ajaxMethod" select="$ajaxMethod"/>
					<xsl:with-param name="option">
						<xsl:element name="option"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="m8:path( 'r', 'index' )/predicate/*[name()=$predicateName and name() != 'i' ]" xml:lang="вывод экземпляров типа">
				<xsl:message>			Вывод параметра <xsl:value-of select="$predicateName"/> списком экземпляров типа</xsl:message>
				<xsl:call-template name="inputParamOfPort">
					<xsl:with-param name="inputType" select="$inputType"/>
					<xsl:with-param name="size" select="$size"/>
					<xsl:with-param name="questName" select="$questName"/>
					<xsl:with-param name="predicateName" select="$predicateName"/>
					<xsl:with-param name="selectedValue" select="$selectedValue"/>
					<xsl:with-param name="sourceValue" select="m8:path( 'r', concat( 'predicate_', $predicateName ) )/*"/>
					<xsl:with-param name="sortSelect" select="$sortSelect"/>
					<xsl:with-param name="titleSelect" select="$titleSelect"/>
					<xsl:with-param name="ajaxMethod" select="$ajaxMethod"/>
					<xsl:with-param name="option">
						<xsl:element name="option"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:message>			Вывод параметра <xsl:value-of select="$predicateName"/> без селекта</xsl:message>
				<xsl:call-template name="inputParamOfPort">
					<xsl:with-param name="inputType" select="$inputType"/>
					<xsl:with-param name="size" select="$size"/>
					<xsl:with-param name="questName" select="$questName"/>
					<xsl:with-param name="predicateName" select="$predicateName"/>
					<xsl:with-param name="selectedValue" select="$selectedValue"/>
					<xsl:with-param name="sortSelect" select="$sortSelect"/>
					<xsl:with-param name="titleSelect" select="$titleSelect"/>
					<xsl:with-param name="ajaxMethod" select="$ajaxMethod"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--

	-->
	<xsl:template name="inputParamOfPort">
		<xsl:param name="inputType"/>
		<xsl:param name="size"/>
		<xsl:param name="questName"/>
		<xsl:param name="predicateName"/>
		<xsl:param name="selectedValue"/>
		<!-- здесь должна прийти сама нода для обращения к ней без /*, но внутри должна быть нода активирующего трипла для удления -->
		<xsl:param name="sourceValue"/>
		<xsl:param name="sortSelect"/>
		<xsl:param name="codeSelect"/>
		<xsl:param name="titleSelect"/>
		<xsl:param name="ajaxMethod"/>
		<xsl:param name="option"/>
		<xsl:param name="method"/>
		<xsl:variable name="params_of_quest" select="m8:path( $fact, $author, $quest, 'port' )/*"/>
		<xsl:message>	inputParamOfPort :: sourceValue: <xsl:copy-of select="count(exsl:node-set($sourceValue)/*)"/>
		</xsl:message>
		<xsl:choose>
			<!--
							ВЫВОД ЗАПРОСА ФАЙЛА
-->
			<xsl:when test="$predicateName = 'n'">
				<input type="file" name="file">
					<xsl:if test="not($ajaxMethod)">
						<xsl:attribute name="onchange">this.form.submit()</xsl:attribute>
					</xsl:if>
				</input>
				<xsl:if test="name($selectedValue) != 'r'">
					<a href="{$start/@prefix}base/{name($selectedValue)}/value.tsv">text</a>|<a href="{$start/@prefix}m8/{substring(name($selectedValue),1,1)}/{name($selectedValue)}/value.xml">xml</a>
				</xsl:if>
			</xsl:when>
			<!--
							ВЫВОД TEXTAREA
-->
			<xsl:when test="$predicateName = 'd' ">
				<xsl:variable name="name">
					<xsl:apply-templates select="$selectedValue" mode="titleWord"/>
				</xsl:variable>
				<textarea name="{$predicateName}" placeholder="описание объекта" cols="32" rows="3">
					<xsl:if test="not($ajaxMethod)">
						<xsl:attribute name="onchange">this.form.submit()</xsl:attribute>
					</xsl:if>
					<xsl:if test="$name=''">
						<xsl:attribute name="onfocus"><xsl:text>$(this).val('')</xsl:text></xsl:attribute>
						<xsl:text> </xsl:text>
					</xsl:if>
					<xsl:value-of select="$name"/>
				</textarea>
			</xsl:when>
			<!--
							ВЫВОД ИЗ СПИСКА DIV-ов
-->
			<xsl:when test="exsl:node-set($sourceValue)/div">
				<xsl:message>			Формирование селекта из tsv</xsl:message>
				<xsl:variable name="objectTitle">
					<xsl:choose>
						<xsl:when test="$selectedValue/span[1]">
							<xsl:value-of select="$selectedValue/span[1]"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="$selectedValue" mode="simpleName"/>
							<!--titleWord-->
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="titleSpan">
					<xsl:choose>
						<xsl:when test="$titleSelect">
							<xsl:value-of select="$titleSelect"/>
						</xsl:when>
						<xsl:otherwise>1</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="count(exsl:node-set($sourceValue)/*) = 2 and exsl:node-set($sourceValue)/*[1]/span=0 and exsl:node-set($sourceValue)/*[2]/span=1 and not(exsl:node-set($sourceValue)/*[1]/span[2])">
						<xsl:if test="name($selectedValue)='r1'">
							<input type="hidden" name="{$predicateName}" value="0"/>
						</xsl:if>
						<input type="checkbox" name="{$predicateName}" value="1">
							<xsl:if test="not($ajaxMethod)">
								<xsl:attribute name="onchange">this.form.submit()</xsl:attribute>
							</xsl:if>
							<xsl:if test="name($selectedValue)='r1'">
								<xsl:attribute name="checked"><xsl:value-of select="'checked'"/></xsl:attribute>
							</xsl:if>
						</input>
					</xsl:when>
					<xsl:when test="$inputType">
						<xsl:for-each select="exsl:node-set($sourceValue)/*">
							<xsl:sort select="span[$sortSelect]"/>
							<input class="input-category" type="{$inputType}" name="{$predicateName}" value="{span[1]}" id="{span[1]}">
								<xsl:for-each select="span">
									<xsl:attribute name="span{position()}"><xsl:value-of select="."/></xsl:attribute>
								</xsl:for-each>
								<xsl:if test="not($ajaxMethod)">
									<xsl:attribute name="onchange">this.form.submit()</xsl:attribute>
								</xsl:if>
								<xsl:if test="@description">
									<xsl:attribute name="description"><xsl:value-of select="@description"/></xsl:attribute>
								</xsl:if>
								<xsl:if test="span[1] = $objectTitle">
									<xsl:attribute name="checked"><xsl:value-of select="'checked'"/></xsl:attribute>
								</xsl:if>
							</input>
							<label class="list-group-item" for="{span[1]}">
								<xsl:value-of select="span[number($titleSpan)]"/>
							</label>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="valueNames">
							<xsl:for-each select="$params_of_quest[name()=$predicateName]/*">
								<xsl:element name="{name()}">
									<xsl:apply-templates select="." mode="titleWord"/>
								</xsl:element>
							</xsl:for-each>
						</xsl:variable>
						<select name="{$predicateName}" size="{$size}" objectTitle="{$objectTitle}">
							<xsl:attribute name="class"><xsl:choose><xsl:when test="exsl:node-set($sourceValue)/*[20]" xml:lang="для городов в калькуляторе TN например">custom-<xsl:value-of select="$ajaxMethod"/>-select</xsl:when><xsl:otherwise>simple-<xsl:value-of select="$ajaxMethod"/>-select</xsl:otherwise></xsl:choose></xsl:attribute>
							<xsl:if test="not($ajaxMethod)">
								<xsl:attribute name="onchange">this.form.submit()</xsl:attribute>
							</xsl:if>
							<xsl:copy-of select="$option"/>
							<xsl:for-each select="exsl:node-set($sourceValue)/*">
								<xsl:sort select="span[$sortSelect]"/>
								<xsl:variable name="currentVal" select="span[1]"/>
								<xsl:if test="1 or not(exsl:node-set($valueNames)/*[.=$currentVal]) or $currentVal=$objectTitle" xml:lang="требуется проверка необходимости">
									<option value="{span[1]}">
										<xsl:if test="span[1] = $objectTitle">
											<xsl:attribute name="selected"><xsl:value-of select="'selected'"/></xsl:attribute>
										</xsl:if>
										<xsl:value-of select="span[number($titleSpan)]"/>
									</option>
								</xsl:if>
							</xsl:for-each>
						</select>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!--
							ВЫВОД ИЗ СПИСКА НОД
-->
			<xsl:when test="exsl:node-set($sourceValue)/*">
				<!--[2] выводить селект нужно вероятно всегда когда есть список-->
				<xsl:message>			Формирование селекта из списка нод</xsl:message>
				<xsl:choose>
					<xsl:when test="$inputType">
						<xsl:for-each select="exsl:node-set($sourceValue)/*">
							<xsl:sort select="@sort"/>
							<!--<xsl:value-of select="name($selectedValue)"/> = <xsl:value-of select="name()"/>-->
							<input class="input-radio" type="{$inputType}" name="{$predicateName}" value="{name()}" id="{name()}">
								<xsl:if test="not($ajaxMethod)">
									<xsl:attribute name="onchange">this.form.submit()</xsl:attribute>
								</xsl:if>
								<xsl:if test="@description">
									<xsl:attribute name="description"><xsl:value-of select="@description"/></xsl:attribute>
								</xsl:if>
							</input>
							<label class="label-block" for="{name()}">
								<xsl:if test="@activity!=1">
									<xsl:attribute name="style">position: relative</xsl:attribute>
									<div style="position: absolute; right: 3px; top: 0; font-size: .6em; background-color: #B99; padding: 0 .5em; margin-right: .3em; letter-spacing: .2em; color: white ">не активно</div>
								</xsl:if>
								<xsl:if test="@imgPath">
									<img src="{@imgPath}/front.jpg" alt="{@code}" width="60"/>
								</xsl:if>
								<p>
									<xsl:value-of select="@title"/>
								</p>
							</label>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<select name="{$predicateName}">
							<xsl:if test="not($ajaxMethod)">
								<xsl:attribute name="onchange">this.form.submit()</xsl:attribute>
							</xsl:if>
							<xsl:attribute name="class"><xsl:choose><xsl:when test="exsl:node-set($sourceValue)/*[20]" xml:lang="для городов в калькуляторе TN например">custom-</xsl:when><xsl:otherwise>simple-</xsl:otherwise></xsl:choose><xsl:value-of select="$ajaxMethod"/><xsl:text>-select</xsl:text></xsl:attribute>
							<xsl:copy-of select="$option"/>
							<xsl:for-each select="exsl:node-set($sourceValue)/*">
								<xsl:sort select="@sort"/>
								<xsl:variable name="valueName" select="name()"/>
								<xsl:if test="not($params_of_quest[name()=$predicateName]/*[name()=$valueName]) or name()=name($selectedValue)">
									<option value="{$valueName}">
										<xsl:if test="$valueName=name($selectedValue)">
											<xsl:attribute name="selected"><xsl:value-of select="'selected'"/></xsl:attribute>
										</xsl:if>
										<xsl:variable name="title">
											<xsl:choose>
												<xsl:when test="@on_display">
													<xsl:value-of select="@on_display"/>
												</xsl:when>
												<xsl:when test="@title">
													<xsl:value-of select="@title"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:apply-templates select="." mode="simpleName"/>
													<!--titleWord-->
												</xsl:otherwise>
											</xsl:choose>
										</xsl:variable>
										<xsl:value-of select="$title"/>
									</option>
								</xsl:if>
							</xsl:for-each>
						</select>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!--
							ВЫВОД ТЕКСТОВОГО ПОЛЯ
-->
			<xsl:otherwise>
				<xsl:message>			Вывод текстового поля</xsl:message>
				<xsl:variable name="title">
					<xsl:apply-templates select="$selectedValue" mode="titleWord"/>
				</xsl:variable>
				<input type="text" name="{$predicateName}" size="{$size}">
					<xsl:if test="not($ajaxMethod)">
						<xsl:attribute name="onchange">this.form.submit()</xsl:attribute>
					</xsl:if>
					<xsl:if test="$selectedValue/@invalid or $selectedValue/../../@invalid">
						<xsl:attribute name="invalid">invalid</xsl:attribute>
					</xsl:if>
					<xsl:attribute name="value"><xsl:choose><xsl:when test="starts-with( name($selectedValue), 'r' )"><xsl:value-of select="translate( $title, '.', ',' )"/></xsl:when><xsl:otherwise><xsl:value-of select="$title"/></xsl:otherwise></xsl:choose></xsl:attribute>
				</input>
				<xsl:if test="starts-with( $title, 'http' )">
					<xsl:text> </xsl:text>
					<a href="{$title}">link</a>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--

	-->
	<xsl:template name="authorDef">
		<html>
			<head>
				<xsl:call-template name="TitleAndMisk"/>
			</head>
			<body>
				<xsl:if test="/*/*/@referer"> </xsl:if>
				<div style="text-align: center; padding: 2em; color: red">
					<xsl:value-of select="@history"/>
				</div>
				<table width="100%" cellpadding="6">
					<tr>
						<td valign="top" align="center">
							<h1>Вход</h1>
							<div>Укажите ваши логин и пароль</div>
							<form style="padding: 2em" action="{$start/@prefix}{$start/@m8path}" method="get">
								<input type="hidden" name="logout" value="1"/>
								<xsl:if test="$start/@error='no_user'">
									<div style="color: red">Пользователь с данным именем не зарегистрирован</div>
									<br/>
								</xsl:if>
						
						Логин: <input type="text" name="login"/>
								<!-- value="{$login}"-->
								<br/>
								<br/>
								<xsl:if test="$start/@error='bad_password'">
									<div style="color: red">Пароль указан не верно</div>
									<br/>
								</xsl:if>
								<xsl:if test="$start/@error='no_password'">
									<div style="color: red">Укажите пароль</div>
									<br/>
								</xsl:if>
					Пароль: <input type="password" name="password"/>
								<br/>
								<br/>
								<button type="submit">Войти</button>
							</form>
						</td>
						<td valign="top" align="center" style="display: none">
							<h1>Регистрация</h1>
							<form method="get" id="rs_first">
								<input type="hidden" name="author"/>
								<xsl:if test="@history='busy'">
									<div style="color: red">Имя уже занято </div>
									<!-- -->
								</xsl:if>
					Имя: <input type="text" name="new_author"/>
								<!---->
								<br/>(без пробелов латиницей)                                        <br/>
								<br/>
								<xsl:if test="@history and (@history='bad_retype' or @history='no_password')">
									<div style="color: red">
										<xsl:choose>
											<xsl:when test="@history='bad_retype'">Повторение пароля не совпало. Введите заново.</xsl:when>
											<xsl:when test="@history='no_password'">Задайте пароль</xsl:when>
										</xsl:choose>
									</div>
								</xsl:if>
					Пароль: <input type="password" name="new_password"/>
								<br/>
								<br/>
					Повтор: <input type="password" name="new_password2"/>
								<br/>
								<br/>
								<button type="submit" formaction="{$start/@prefix}">Регистрация</button>
								<br/>
							</form>
						</td>
					</tr>
				</table>
			</body>
		</html>
	</xsl:template>
	<!--

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%                                                             %%%%%%%%%%%%%%
%%%%%%%%%%%%%%                    SERIALIZE    						%%%%%%%%%%%%%%                
%%%%%%%%%%%%%%                                                            %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	-->
	<xsl:template match="*" mode="serialize">
		<xsl:param name="continue"/>
		<div>
			<xsl:attribute name="style">padding-left: 2em; font-size: .95em; <xsl:if test="not($continue)">color: #<xsl:value-of select="substring( count(.//*|./@*) * 210, 1, 3 )"/></xsl:if></xsl:attribute>
			<xsl:text>&lt;</xsl:text>
			<xsl:value-of select="name(.)"/>
			<xsl:apply-templates select="@*" mode="serialize"/>
			<xsl:text>&gt;</xsl:text>
			<xsl:apply-templates mode="serialize">
				<xsl:with-param name="continue" select="1"/>
			</xsl:apply-templates>
			<xsl:text>&lt;/</xsl:text>
			<xsl:value-of select="name(.)"/>
			<xsl:text>&gt;</xsl:text>
		</div>
	</xsl:template>
	<xsl:template match="text()" mode="serialize">
		<xsl:value-of select="."/>
	</xsl:template>
	<xsl:template match="@*" mode="serialize">
		<xsl:text> </xsl:text>
		<xsl:value-of select="name()"/>
		<xsl:text>="</xsl:text>
		<xsl:value-of select="."/>
		<xsl:text>"</xsl:text>
	</xsl:template>
	<!--

	-->
	<xsl:template name="footer">
		<xsl:if test="$user != 'guest'">
			<!-- or $start/@debug-->
			<div style="position: fixed;  bottom: 5px; left: 10px; z-index: 1; color:gray">
				<!--<a href="{$start/@prefix}" style="color:gray">START</a>
					<xsl:text> | </xsl:text>-->
				<xsl:choose>
					<xsl:when test="$ctrl = 'formulyar' ">
						<!--<xsl:for-each select="document( concat( $start/@DOCUMENT_ROOT, '/m8/avatar.xml' ) )/*/*">
							<a href="{$start/@prefix}a/{@id}/m8/{substring($fact,1,1)}/{$fact}/{$author}/{$quest}" style="color:gray">
								<xsl:value-of select="@title"/>
>>>>>>> d547d9c381a0dae64e684b2983354d6e51b2146e
							</a>
							<xsl:if test="position()!=last()">
								<xsl:text> | </xsl:text>
							</xsl:if>
						</xsl:for-each>-->
						<a href="{$start/@prefix}a/{$avatar}/m8/{substring($fact,1,1)}/{$fact}/{$author}/{$quest}" style="color:orange">публичный раздел</a>
					</xsl:when>
					<xsl:otherwise>
						<a href="{$start/@prefix}a/formulyar/m8/{substring($fact,1,1)}/{$fact}/{$author}/{$quest}" style="color:brown">aдминистративный раздел</a>
					</xsl:otherwise>
				</xsl:choose>
				<!--<xsl:text> | </xsl:text>
					<a href="{$start/@prefix}system/m8/{substring($fact,1,1)}/{$fact}/{$author}/{$quest}" style="color:gray">sys</a>
					<xsl:text> | </xsl:text>
					<a href="{$start/@prefix}m8/{substring($fact,1,1)}/{$fact}/{$author}" style="color:gray">refresh</a>
					<xsl:text> | </xsl:text>
					<a href="{$start/@prefix}m8/{substring($fact,1,1)}/{$fact}/{$author}/{$quest}/port.xml" style="color:gray">xml</a>-->
			</div>
		</xsl:if>
		<xsl:if test="$user != 'guest' ">
			<!--//-->
			<div style="position: fixed;  bottom: 5px; left: 10px; z-index: 1; color:gray; display: none">
				<xsl:value-of select="$avatar"/>
			</div>
			<div style="position: fixed; bottom: 5px; right: 5px; color: gray; z-index: 1">
				<xsl:value-of select="$start/@version"/>
				<xsl:text> | </xsl:text>
				<!--<xsl:text> &lt;- </xsl:text>-->
				<xsl:choose>
					<xsl:when test="$start/@debug">
						<a href="{$start/@prefix}a/{$ctrl}/{m8:dir( $fact, $author, $quest )}/?debug=switch" style="color: purple">debug on</a>
					</xsl:when>
					<xsl:otherwise>
						<a href="{$start/@prefix}a/{$ctrl}/{m8:dir( $fact, $author, $quest )}/?debug=switch" style="color: gray">debug off</a>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text> | </xsl:text>
				<!--<xsl:if test="$calcName">
						<xsl:value-of select="$calcName"/>
						<xsl:text> | </xsl:text>
					</xsl:if>-->
				<a href="{$start/@prefix}formulyar/{substring($fact,1,1)}/{$fact}/{$author}/{$quest}/port.xml" style="color:gray">
					<xsl:value-of select="$localtime"/>
				</a>
				<xsl:text> |  </xsl:text>
				<xsl:value-of select="$user"/>
				<xsl:text> | </xsl:text>
				<a href="{$start/@prefix}a/{$avatar}/{m8:dir( $fact, $author, $quest )}/?logout=true" style="color: red">выйти</a>
			</div>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
