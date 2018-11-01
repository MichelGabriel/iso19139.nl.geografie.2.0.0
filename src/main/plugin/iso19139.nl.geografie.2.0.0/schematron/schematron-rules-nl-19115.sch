﻿<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
	<sch:ns uri="http://www.isotc211.org/2005/gmd" prefix="gmd"/>
	<sch:ns uri="http://www.isotc211.org/2005/gco" prefix="gco"/>
	<sch:ns uri="http://www.isotc211.org/2005/gmx" prefix="gmx"/>
	<sch:ns uri="http://www.opengis.net/gml" prefix="gml"/>
	<sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
	<sch:ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
	<sch:ns uri="http://www.w3.org/2004/02/skos/core#" prefix="skos"/>
	<sch:ns prefix="geonet" uri="http://www.fao.org/geonetwork"/>

	<sch:let name="lowercase" value="'abcdefghijklmnopqrstuvwxyz'"/>
	<sch:let name="uppercase" value="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
	<!-- werkt nog niet
	<sch:let name="gemet-nl" value="document('GEMET-InspireThemes-nl.rdf')"/>
	-->

	<sch:pattern id="Validatie_tegen_het_Nederlands_metadata_profiel_op_ISO_19115_versie_2">
		<sch:title>Validatie tegen het Nederlands profiel op ISO 19115 voor geografie versie 2.0.0 (2017)</sch:title>
		<!-- INSPIRE Thesaurus en Conformiteit-->
		<sch:let name="thesaurus1" value="normalize-space(/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords[1]/gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gco:CharacterString)"/>
		<sch:let name="thesaurus2" value="normalize-space(/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords[2]/gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gco:CharacterString)"/>
		<sch:let name="thesaurus3" value="normalize-space(/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords[3]/gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gco:CharacterString)"/>
		<sch:let name="thesaurus4" value="normalize-space(/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords[4]/gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gco:CharacterString)"/>
		<sch:let name="thesaurus" value="concat(string($thesaurus1),string($thesaurus2),string($thesaurus3),string($thesaurus4))"/>
		<sch:let name="thesaurus_INSPIRE_Exsists" value="contains($thesaurus,'GEMET - INSPIRE themes, version 1.0')"/>
		<sch:let name="conformity_Spec_Title1" value="normalize-space(//gmd:MD_Metadata/gmd:dataQualityInfo[1]/gmd:DQ_DataQuality/gmd:report[1]/gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title/gco:CharacterString)"/>
		<sch:let name="conformity_Spec_Title2" value="normalize-space(//gmd:MD_Metadata/gmd:dataQualityInfo[1]/gmd:DQ_DataQuality/gmd:report[2]/gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title/gco:CharacterString)"/>
		<sch:let name="conformity_Spec_Title3" value="normalize-space(//gmd:MD_Metadata/gmd:dataQualityInfo[1]/gmd:DQ_DataQuality/gmd:report[3]/gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title/gco:CharacterString)"/>
		<sch:let name="conformity_Spec_Title4" value="normalize-space(//gmd:MD_Metadata/gmd:dataQualityInfo[1]/gmd:DQ_DataQuality/gmd:report[4]/gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title/gco:CharacterString)"/>
		<sch:let name="conformity_Spec_Title_All" value="concat(string($conformity_Spec_Title1),string($conformity_Spec_Title2),string($conformity_Spec_Title3),string($conformity_Spec_Title4))"/>
		<sch:let name="conformity_Spec_Title_Exsists" value="contains($conformity_Spec_Title_All,'VERORDENING (EU) Nr. 1089/2010 VAN DE COMMISSIE van 23 november 2010 ter uitvoering van Richtlijn 2007/2/EG van het Europees Parlement en de Raad betreffende de interoperabiliteit van verzamelingen ruimtelijke gegevens en van diensten met betrekking tot ruimtelijke gegevens')"/>

		<sch:rule id="Algemene_metadata_regels"  context="/gmd:MD_Metadata">

		<!-- schemalocatie controleren, overeenkomstig inspire en nl profiel -->

			<sch:assert id="Schema_locatie" test="contains(normalize-space(@xsi:schemaLocation), 'http://schemas.opengis.net/iso/19139/20060504/gmd/gmd.xsd')">Het ISO 19139 XML document mist een verplichte schema locatie. De schema locatie http://schemas.opengis.net/iso/19139/20060504/gmd/gmd.xsd moet aanwezig zijn.
			</sch:assert>
			<sch:report id="Schema_locatie_info" test="contains(normalize-space(@xsi:schemaLocation), 'http://schemas.opengis.net/iso/19139/20060504/gmd/gmd.xsd')">Het ISO 19139 XML document bevat de schema locatie http://schemas.opengis.net/iso/19139/20060504/gmd/gmd.xsd
			</sch:report>

		<!--  fileIdentifier for report https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#metadata-unieke-identifier -->
			<sch:let name="fileIdentifier" value="normalize-space(gmd:fileIdentifier/gco:CharacterString)"/>
            		<!-- Taal van de metadata https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#taal-van-de-metadata
				NB: voor deze tests is dut en eng voldoende -->
			<sch:let name="mdLanguage" value="(gmd:language/*/@codeListValue = 'dut' or gmd:language/*/@codeListValue = 'eng')"/>
            			<sch:let name="mdLanguage_value" value="string(gmd:language/*/@codeListValue)"/>

		<!-- Metadata hiërarchielevel variable  -->
			<!-- Hiërarchieniveau https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#hi%C3%ABrarchieniveau -->
			<sch:let name="hierarchyLevel" value="(gmd:hierarchyLevel[1]/*/@codeListValue = 'dataset' or gmd:hierarchyLevel[1]/*/@codeListValue = 'series')"/>
			<sch:let name="hierarchyLevel_value" value="string(gmd:hierarchyLevel[1]/*/@codeListValue)"/>
          <!-- Hiërarchieniveau naam, Beschrijving hiërarchisch niveau https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#hi%C3%ABrarchieniveaunaam-->
			<sch:let name="hierarchyLevelName" value="normalize-space(gmd:hierarchyLevelName[1]/gco:CharacterString)"/>
		<!-- Metadata verantwoordelijke organisatie (name) https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#verantwoordelijke-organisatie-metadata -->
			<sch:let name="mdResponsibleParty_OrganisationString" value="normalize-space(gmd:contact[1]/gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString)"/>
			<sch:let name="mdResponsibleParty_OrganisationURI" value="normalize-space(gmd:contact[1]/gmd:CI_ResponsibleParty/gmd:organisationName/gmx:Anchor/@xlink:href)"/>
			<sch:let name="mdResponsibleParty_OrganisationAnchorLabel" value="normalize-space(gmd:contact[1]/gmd:CI_ResponsibleParty/gmd:organisationName/gmx:Anchor)"/>

		<!-- Metadata verantwoordelijke organisatie (role) NL profiel https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#verantwoordelijke-organisatie-metadata:-rol -->
			<sch:let name="mdResponsibleParty_Role" value="gmd:contact[1]/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'resourceProvider' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'custodian' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'owner' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'user' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'distributor' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'owner' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'originator' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'pointOfContact' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'principalInvestigator' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'processor' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'publisher' or gmd:contact/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'author'"/>

		<!--  voor INSPIRE toegestane waarde in combi met INSPIRE specificatie -->

			<sch:let name="mdResponsibleParty_Role_INSPIRE" value="gmd:contact[1]/gmd:CI_ResponsibleParty/gmd:role/*/@codeListValue = 'pointOfContact' "/>

		<!-- Metadata verantwoordelijke organisatie (email) https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#verantwoordelijke-organisatie-metadata:-e-mail -->
			<sch:let name="mdResponsibleParty_Mail" value="normalize-space(gmd:contact[1]/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/gmd:CI_Address/gmd:electronicMailAddress[1]/gco:CharacterString)"/>
        <!-- Metadata datum https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#metadatadatum -->
			<sch:let name="dateStamp" value="normalize-space(string(gmd:dateStamp/gco:Date))"/>
		<!-- Metadatastandaard naam https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#metadata-standaard-naam -->
			<sch:let name="metadataStandardName" value="translate(normalize-space(gmd:metadataStandardName/gco:CharacterString), $lowercase, $uppercase)"/>
		<!-- Metadatastandaard versie https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#metadatastandaard-versie -->
			<sch:let name="metadataStandardVersion" value="translate(normalize-space(gmd:metadataStandardVersion/gco:CharacterString), $lowercase, $uppercase)"/>

			<!-- Metadata karakterset : in v.2.0.0 optioneel gewworden -->
			<sch:let name="metadataCharacterset" value="string(gmd:characterSet/*/@codeListValue)"/>
			<sch:let name="metadataCharacterset_value" value="gmd:characterSet/*[@codeListValue ='ucs2' or @codeListValue ='ucs4' or @codeListValue ='utf7' or @codeListValue ='utf8' or @codeListValue ='utf16' or @codeListValue ='8859part1' or @codeListValue ='8859part2' or @codeListValue ='8859part3' or @codeListValue ='8859part4' or @codeListValue ='8859part5' or @codeListValue ='8859part6' or @codeListValue ='8859part7' or @codeListValue ='8859part8' or @codeListValue ='8859part9' or @codeListValue ='8859part10' or @codeListValue ='8859part11' or  @codeListValue ='8859part12' or @codeListValue ='8859part13' or @codeListValue ='8859part14' or @codeListValue ='8859part15' or @codeListValue ='8859part16' or @codeListValue ='jis' or @codeListValue ='shiftJIS' or @codeListValue ='eucJP' or @codeListValue ='usAscii' or @codeListValue ='ebcdic' or @codeListValue ='eucKR' or @codeListValue ='big5' or @codeListValue ='GB2312']"/>


		<!-- rules and assertions -->

			<sch:assert id="Metadat__ID__ISO_nr._2_" test="$fileIdentifier">Er is geen Metadata ID (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#metadata-unieke-identifier) opgegeven.</sch:assert>
			<sch:report id="Metadat__ID__ISO_nr._2__info" test="$fileIdentifier">Metadata ID: <sch:value-of select="$fileIdentifier"/>
			</sch:report>
			<sch:assert id="Metadata_taal__ISO_nr._3_" test="$mdLanguage">De metadata taal (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#taal-van-de-metadata) ontbreekt of heeft een verkeerde waarde. Dit hoort een waarde en verwijzing naar de codelijst te zijn.</sch:assert>
			<sch:report id="Metadata_taal__ISO_nr._3__info" test="$mdLanguage">Metadata taal (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#taal-van-de-metadata) voldoet
			 </sch:report>

			<sch:assert id="Metadata_hierarchieniveau__ISO_nr._6_" test="$hierarchyLevel">Metadata hierarchieniveau (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#hi%C3%ABrarchieniveau) ontbreekt of heeft een verkeerde waarde</sch:assert>
			<sch:report id="Metadata_hierarchieniveau__ISO_nr._6__info" test="$hierarchyLevel">Metadata hierarchieniveau (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#hi%C3%ABrarchieniveau) voldoet</sch:report>

        	<sch:assert id="Beschrijving_hierarchisch_niveau__ISO_nr._7_" test="not($hierarchyLevel_value = 'series' and not($hierarchyLevelName))">Beschrijving hierarchisch niveau (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#hi%C3%ABrarchieniveaunaam) ontbreekt. Dit is verplicht als hierarchieniveau = 'series'.</sch:assert>
			<sch:report id="Beschrijving_hierarchisch_niveau__ISO_nr._7__info" test="$hierarchyLevelName">Tenminste 1 beschrijving hierarchisch niveau (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#hi%C3%ABrarchieniveaunaam) is gevonden
			</sch:report>
			<sch:assert id="Naam_organisatie_metadata__ISO_nr._376_" test="$mdResponsibleParty_OrganisationString or ($mdResponsibleParty_OrganisationURI and $mdResponsibleParty_OrganisationAnchorLabel)">Naam en/of de URI (in geval van een Anchor) van de organisatie metadata (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#verantwoordelijke-organisatie-metadata) ontbreekt.</sch:assert>
			<sch:report id="Naam_organisatie_metadata__ISO_nr._376__info" test="$mdResponsibleParty_OrganisationString or $mdResponsibleParty_OrganisationURI">Naam organisatie metadata (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#verantwoordelijke-organisatie-metadata): <sch:value-of select="$mdResponsibleParty_OrganisationString"/><sch:value-of select="$mdResponsibleParty_OrganisationURI"/>
			</sch:report>
			<sch:assert id="Rol_organisatie_metadata__ISO_nr._379_" test="$mdResponsibleParty_Role">Rol organisatie metadata (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#verantwoordelijke-organisatie-bron:-rol) ontbreekt of heeft een verkeerde waarde</sch:assert>
			<sch:report id="Rol_organisatie_metadata__ISO_nr._379__info" test="$mdResponsibleParty_Role">Rol organisatie metadata (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#verantwoordelijke-organisatie-bron:-rol): <sch:value-of select="$mdResponsibleParty_Role"/>
			</sch:report>
		<!-- In geval van INSPIRE: Rol organisatie metadata in combi met specificatie INSPIRE -->
			<sch:assert id="Rol_organisatie_metadata__ISO_nr._379_INSPIRE" test="not($conformity_Spec_Title_Exsists) or ($conformity_Spec_Title_Exsists and $mdResponsibleParty_Role_INSPIRE)">Rol organisatie metadata (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#verantwoordelijke-organisatie-bron:-rol) ontbreekt of heeft een verkeerde waarde, deze dient voor INSPIRE contactpunt te zijn</sch:assert>
		<!-- eind INSPIRE in combi met specificatie INSPIRE -->
			<sch:assert id="E-mail_organisatie_metadata__ISO_nr._386_"  test="$mdResponsibleParty_Mail">E-mail organisatie metadata (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#verantwoordelijke-organisatie-metadata:-e-mail) ontbreekt</sch:assert>
			<sch:report id="E-mail_organisatie_metadata__ISO_nr._386__info" test="$mdResponsibleParty_Mail">E-mail organisatie metadata (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#verantwoordelijke-organisatie-metadata:-e-mail): <sch:value-of select="$mdResponsibleParty_Mail"/>
			</sch:report>
			<sch:assert id="Metadata_datum__ISO_nr._9_" test="((number(substring(substring-before($dateStamp,'-'),1,4)) &gt; 1000 ))">Metadata datum (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#metadatadatum) ontbreekt of heeft het verkeerde formaat (YYYY-MM-DD)</sch:assert>
			<sch:report id="Metadata_datum__ISO_nr._9__info" test="$dateStamp">Metadata datum (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#metadatadatum): <sch:value-of select="$dateStamp"/>
			</sch:report>

			<sch:assert id="Metadatastandaard_naam__ISO_nr._10_" test="$metadataStandardName = 'ISO 19115'">Metadatastandaard naam (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#metadata-standaard-naam) ontbreekt of is niet correct ingevuld, Metadatastandaard naam dient de waarde 'ISO 19115' te hebben</sch:assert>
			<sch:report id="Metadatastandaard_naam__ISO_nr._10__info" test="$metadataStandardName">Metadatastandaard naam (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#metadata-standaard-naam): <sch:value-of select="$metadataStandardName"/>
			</sch:report>
			<sch:assert id="Versie_metadatastandaard__ISO_nr._11_" test="contains($metadataStandardVersion, 'PROFIEL OP ISO 19115')">Versie metadatastandaard  (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#metadatastandaard-versie) ontbreekt of is niet correct ingevuld, Metadatastandaard versie dient de waarde 'Nederlands metadata profiel op ISO 19115 voor geografie 2.0' te bevatten</sch:assert>
			<sch:report id="Versie_metadatastandaard__ISO_nr._11__info" test="$metadataStandardVersion">Versie metadatastandaard (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#metadatastandaard-versie): <sch:value-of select="$metadataStandardVersion"/>
			</sch:report>

			<!-- TB: optioneel geworden in v 2.0.0, geen test meer mogelijk -->
			<!-- <sch:assert id="Metadata karakterset (ISO nr. 4)" test="not($metadataCharacterset) or $metadataCharacterset_value">Metadata karakterset (ISO nr. 4) ontbreekt of heeft een verkeerde waarde</sch:assert>
			<sch:report id="Metadata karakterset (ISO nr. 4) info" test="not($metadataCharacterset) or $metadataCharacterset_value">Metadata karakterset (ISO nr. 4) opgegeven en voldoet</sch:report> -->

		<!-- alle regels over elementen binnen gmd:identificationInfo -->

		<!-- Dataset titel, https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#titel-van-de-bron -->
			<sch:let name="datasetTitle" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString)"/>

			<!-- Datum van de bron en Datum type van de bron, https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#datum-van-de-bron en https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#datum-type-van-de-bron-->
			<sch:let name="publicationDateString" value="string(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/*[./gmd:CI_Date/gmd:dateType/*/@codeListValue='publication']/gmd:CI_Date/gmd:date/gco:Date)"/>
			<sch:let name="creationDateString" value="string(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/*[./gmd:CI_Date/gmd:dateType/*/@codeListValue='creation']/gmd:CI_Date/gmd:date/gco:Date)"/>
			<sch:let name="revisionDateString" value="string(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/*[./gmd:CI_Date/gmd:dateType/*/@codeListValue='revision']/gmd:CI_Date/gmd:date/gco:Date)"/>
			<sch:let name="publicationDate" value="((number(substring(substring-before($publicationDateString,'-'),1,4)) &gt; 1000 ))"/>
			<sch:let name="creationDate" value="((number(substring(substring-before($creationDateString,'-'),1,4)) &gt; 1000 ))"/>
			<sch:let name="revisionDate" value="((number(substring(substring-before($revisionDateString,'-'),1,4)) &gt; 1000 ))"/>

			<!-- Samenvatting https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#samenvatting -->
			<sch:let name="abstract" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:abstract/gco:CharacterString)"/>

			<!-- Status https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#status -->
			<sch:let name="status" value="gmd:identificationInfo/gmd:MD_DataIdentification/gmd:status/*[@codeListValue = 'completed' or @codeListValue = 'historicalArchive' or @codeListValue = 'obsolete' or @codeListValue = 'onGoing' or @codeListValue = 'planned' or @codeListValue = 'required' or @codeListValue = 'underDevelopment']"/>

			<!-- 5.2.10 Verantwoordelijke organisatie bron https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#verantwoordelijke-organisatie-bron -->
			<sch:let name="responsibleParty_OrganisationString" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact[1]/gmd:CI_ResponsibleParty/gmd:organisationName/gco:CharacterString)"/>
			<sch:let name="responsibleParty_OrganisationURI" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact[1]/gmd:CI_ResponsibleParty/gmd:organisationName/gmx:Anchor/@xlink:href)"/>
			<sch:let name="responsibleParty_OrganisationAnchor" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact[1]/gmd:CI_ResponsibleParty/gmd:organisationName/gmx:Anchor)"/>

		<!-- 5.2.11 Verantwoordelijke organisatie bron: e-mail https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#verantwoordelijke-organisatie-bron-email -->
			<sch:let name="responsibleParty_Mail" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact[1]/gmd:CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address[1]/gmd:CI_Address/gmd:electronicMailAddress[1]/gco:CharacterString)"/>

		<!-- 5.2.12 Verantwoordelijke organisatie bron rol, https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#verantwoordelijke-organisatie-bron:-rol -->
			<sch:let name="responsibleParty_Role" value="gmd:identificationInfo/gmd:MD_DataIdentification/gmd:pointOfContact[1]/gmd:CI_ResponsibleParty/gmd:role/*[@codeListValue = 'resourceProvider' or @codeListValue = 'custodian' or @codeListValue = 'owner' or @codeListValue = 'user' or @codeListValue = 'distributor' or @codeListValue = 'owner' or @codeListValue = 'originator' or @codeListValue = 'pointOfContact' or @codeListValue = 'principalInvestigator' or @codeListValue = 'processor' or @codeListValue = 'publisher' or @codeListValue = 'author']"/>

		<!-- 5.2.13 Trefwoord https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#trefwoord -->
			<sch:let name="keyword" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords[1]/gmd:MD_Keywords/gmd:keyword[1][gco:CharacterString or gmx:Anchor]/*[name() != 'geonet:element'])"/>

		<!-- 5.2.4 Unieke Identifier van de bron, https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#unieke-identifier-van-de-bron -->
			<!-- <sch:let name="identifierAll" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier/gmd:code[./gco:CharacterString or ./gmx:Anchor/]/*)"/> -->
			<sch:let name="identifierString" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier/gmd:code[./gco:CharacterString or ./gmx:Anchor]/*[name() != 'geonet:element'])"/>
			<!--
			<sch:let name="identifierAnchor" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier/gmd:code/gmx:Anchor)"/> -->
			<!-- TODO: Het gebuik van een URI is conditioneel, het is verplicht voor INSPIRE datasets? -> nog inbouwen om te detecteren of het INSPIRE data betreft of doen we dat net als met de oude versie van het profiel in een aparte validator?
		 	-->
			<sch:let name="identifierURI" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier/gmd:code/gmx:Anchor/@xlink:href)"/>

		<!-- Ruimtelijk schema https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#ruimtelijk-schema-van-de-bron
		 codelijst: https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#codelist-spatialrepresentationtypecode -->
		<!-- conditioneel (alleen INSPIRE), dus nu geen controle inbouwen in deze validator -->
			<sch:let name="spatialRepresentationType" value="gmd:identificationInfo/gmd:MD_DataIdentification/gmd:spatialRepresentationType/*[@codeListValue='vector' or @codeListValue='grid' or @codeListValue='textTable' or @codeListValue='tin']"/>

		<!-- Taal van de bron, https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#taal-van-de-bron -->
			<sch:let name="language" value="(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:language/*/@codeListValue = 'dut' or gmd:identificationInfo/gmd:MD_DataIdentification/gmd:language/*/@codeListValue = 'eng')"/>
            <sch:let name="language_value" value="string(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:language/*/@codeListValue)"/>

		<!-- Dataset karakterset, https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#karakterset-van-de-bron:
		 optioneel in v2.0.0, geen test meer
		-->
			<sch:let name="characterset" value="string(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:characterSet/*/@codeListValue)"/>
			<sch:let name="characterset_value" value="gmd:identificationInfo/gmd:MD_DataIdentification/gmd:characterSet/*[@codeListValue ='ucs2' or @codeListValue ='ucs4' or @codeListValue ='utf7' or @codeListValue ='utf8' or @codeListValue ='utf16' or @codeListValue ='8859part1' or @codeListValue ='8859part2' or @codeListValue ='8859part3' or @codeListValue ='8859part4' or @codeListValue ='8859part5' or @codeListValue ='8859part6' or @codeListValue ='8859part7' or @codeListValue ='8859part8' or @codeListValue ='8859part9' or @codeListValue ='8859part10' or @codeListValue ='8859part11' or  @codeListValue ='8859part12' or @codeListValue ='8859part13' or @codeListValue ='8859part14' or @codeListValue ='8859part15' or @codeListValue ='8859part16' or @codeListValue ='jis' or @codeListValue ='shiftJIS' or @codeListValue ='eucJP' or @codeListValue ='usAscii' or @codeListValue ='ebcdic' or @codeListValue ='eucKR' or @codeListValue ='big5' or @codeListValue ='GB2312']"/>

		<!-- Thema's, Onderwerp https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#onderwerp
		codelijst : https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#codelist-spatialrepresentationtypecode -->
			<sch:let name="topicCategory" value="gmd:identificationInfo/gmd:MD_DataIdentification/gmd:topicCategory/*[normalize-space(string-join(text(), '')) = 'farming' or normalize-space(string-join(text(), '')) = 'biota' or normalize-space(string-join(text(), '')) = 'boundaries' or normalize-space(string-join(text(), '')) = 'climatologyMeteorologyAtmosphere' or normalize-space(string-join(text(), '')) = 'economy' or normalize-space(string-join(text(), '')) = 'elevation' or normalize-space(string-join(text(), '')) = 'environment' or normalize-space(string-join(text(), '')) = 'geoscientificInformation' or normalize-space(string-join(text(), '')) = 'health' or normalize-space(string-join(text(), '')) = 'imageryBaseMapsEarthCover' or normalize-space(string-join(text(), '')) = 'intelligenceMilitary' or normalize-space(string-join(text(), '')) = 'inlandWaters' or normalize-space(string-join(text(), '')) = 'location' or normalize-space(string-join(text(), '')) = 'oceans' or normalize-space(string-join(text(), '')) = 'planningCadastre' or normalize-space(string-join(text(), '')) = 'society' or normalize-space(string-join(text(), '')) = 'structure' or normalize-space(string-join(text(), '')) = 'transportation' or normalize-space(string-join(text(), '')) = 'utilitiesCommunication']"/>

		<!-- Gebruiksbeperkingen, https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#gebruiksbeperkingen -->
			<sch:let name="useLimitation" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints[1]/gmd:MD_Constraints/gmd:useLimitation[1]/gco:CharacterString)"/>

			<!-- Overige beperkingen https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#overige-beperkingen -->
			<!-- TODO: Anchor:
				voor elk domein een aparte let-constructie?
				DataLicenties, xlink:href="https://creativecommons.org/publicdomain/mark/*/deed.nl"
				ConditionsApplyingToAccessAndUse, xlink:href="http://inspire.ec.europa.eu/metadata-codelist/ConditionsApplyingToAccessAndUse/noConditionsApply" -> NB: Voor INSPIRE is het gebruik van een Anchor verplicht.
				LimitationsOnPublicAccess, xlink:href="http://inspire.ec.europa.eu/metadata-codelist/LimitationsOnPublicAccess/noLimitations"
				-> NB: Voor INSPIRE is het gebruik van een Anchor verplicht.
		 	-->
	 		<!-- Tests of een waarde of label is opgegeven
			Bij Anchors: of het element ook een xlink:href heeft
			-->
			<sch:let name="otherConstraint1" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints[2]/gmd:MD_LegalConstraints/gmd:otherConstraints[1][gco:CharacterString or gmx:Anchor/@xlink:href]/*[name() != 'geonet:element'])"/>
			<sch:let name="otherConstraint2" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints[2]/gmd:MD_LegalConstraints/gmd:otherConstraints[2][gco:CharacterString or gmx:Anchor/@xlink:href]/*[name() != 'geonet:element'])"/>

			<sch:let name="otherConstraints" value="concat($otherConstraint1,$otherConstraint2)"/>

			<sch:let name="otherConstraintURI1" value="gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints[2]/gmd:MD_LegalConstraints/gmd:otherConstraints[1]/gmx:Anchor"/>
			<sch:let name="otherConstraintURI2" value="gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints[2]/gmd:MD_LegalConstraints/gmd:otherConstraints[2]/gmx:Anchor"/>

			<!-- Thijs Brentjens add the URI to the test as well -->
			<!-- TODO: moet van de codelijst de waarde of de beschrijving gebruikt worden? Op basis van de inhoud van kolom beschrijving vermoed ik dat het die is (maar bij andere codelijsten was het juist de kolom waarde) Voor nu wel de waarde laten staan omdat hiermee onderscheid te maken is.
			-->
			<sch:let name="otherConstraintIsCodelistdatalicense" value="($otherConstraint1='Geen beperkingen' and (contains($otherConstraintURI1/@xlink:href,'://creativecommons.org/publicdomain/mark/') or contains($otherConstraint2,'://creativecommons.org/publicdomain/mark/'))) or ($otherConstraint1='Geen beperkingen' and (contains($otherConstraintURI1/@xlink:href,'://creativecommons.org/publicdomain/zero/') or contains($otherConstraint2,'://creativecommons.org/publicdomain/zero/'))) or ($otherConstraint1='Naamsvermelding verplicht, organisatienaam' and (contains($otherConstraintURI1/@xlink:href,'://creativecommons.org/licenses/by/') or contains($otherConstraint2,'://creativecommons.org/licenses/by/'))) or ($otherConstraint1='Gelijk Delen, Naamsvermelding verplicht, organisatienaam' and (contains($otherConstraintURI1/@xlink:href,'://creativecommons.org/licenses/by-sa/') or contains($otherConstraint2,'://creativecommons.org/licenses/by-sa/'))) or ($otherConstraint1='Niet Commercieel, Naamsvermelding verplicht, organisatienaam' and (contains($otherConstraintURI1/@xlink:href,'://creativecommons.org/licenses/by-nc/') or contains($otherConstraint2,'://creativecommons.org/licenses/by-nc/'))) or ($otherConstraint1='Niet Commercieel, Gelijk Delen, Naamsvermelding verplicht, organisatienaam' and (contains($otherConstraintURI1/@xlink:href,'://creativecommons.org/licenses/by-nc-sa/') or contains($otherConstraint2,'://creativecommons.org/licenses/by-nc-sa/'))) or ($otherConstraint1='Geen Afgeleide Werken, Naamsvermelding verplicht, organisatienaam' and (contains($otherConstraintURI1/@xlink:href,'://creativecommons.org/licenses/by-nd/') or contains($otherConstraint2,'://creativecommons.org/licenses/by-nd/'))) or ($otherConstraint1='Niet Commercieel, Geen Afgeleide Werken, Naamsvermelding verplicht, organisatienaam' and (contains($otherConstraintURI1/@xlink:href,'://creativecommons.org/licenses/by-nc-nd/') or contains($otherConstraint2,'://creativecommons.org/licenses/by-nc-nd/'))) or ($otherConstraint1='Geo Gedeeld licentie' and (starts-with($otherConstraintURI1/@xlink:href,'http') or starts-with($otherConstraint2,'http')) ) or ($otherConstraint2='Geen beperkingen' and (contains($otherConstraintURI2/@xlink:href,'://creativecommons.org/publicdomain/mark/') or contains($otherConstraint1,'://creativecommons.org/publicdomain/mark/'))) or ($otherConstraint2='Geen beperkingen' and (contains($otherConstraintURI2/@xlink:href,'://creativecommons.org/publicdomain/zero/') or contains($otherConstraint1,'://creativecommons.org/publicdomain/zero/'))) or ($otherConstraint2='Naamsvermelding verplicht, organisatienaam' and (contains($otherConstraintURI2/@xlink:href,'://creativecommons.org/licenses/by/') or contains($otherConstraint1,'://creativecommons.org/licenses/by/')) ) or ($otherConstraint2='Gelijk Delen, Naamsvermelding verplicht, organisatienaam' and (contains($otherConstraintURI2/@xlink:href,'://creativecommons.org/licenses/by-sa/') or contains($otherConstraint1,'://creativecommons.org/licenses/by-sa/'))) or ($otherConstraint2='Niet Commercieel, Naamsvermelding verplicht, organisatienaam' and (contains($otherConstraintURI2/@xlink:href,'://creativecommons.org/licenses/by-nc/') or contains($otherConstraint1,'://creativecommons.org/licenses/by-nc/'))) or ($otherConstraint2='Niet Commercieel, Gelijk Delen, Naamsvermelding verplicht, organisatienaam' and (contains($otherConstraintURI2/@xlink:href,'://creativecommons.org/licenses/by-nc-sa/') or contains($otherConstraint1,'://creativecommons.org/licenses/by-nc-sa/'))) or ($otherConstraint2='Geen Afgeleide Werken, Naamsvermelding verplicht, organisatienaam' and (contains($otherConstraintURI2/@xlink:href,'://creativecommons.org/licenses/by-nd/') or contains($otherConstraint1,'://creativecommons.org/licenses/by-nd/'))) or ($otherConstraint2='Niet Commercieel, Geen Afgeleide Werken, Naamsvermelding verplicht, organisatienaam' and (contains($otherConstraintURI2/@xlink:href,'://creativecommons.org/licenses/by-nc-nd/') or contains($otherConstraint1,'://creativecommons.org/licenses/by-nc-nd/'))) or ($otherConstraint2='Geo Gedeeld licentie' and (starts-with($otherConstraintURI2/@xlink:href,'http') or starts-with($otherConstraint1,'http')))" />

			<!-- <sch:let name="otheConstraintsHasValidDatalicenseURI" value="" /> -->

			<!-- test op bestaande URI in een van de codelijsten: https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#codelist-datalicenties, https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#Codelijst-INSPIRE-ConditionsApplyingToAccessAndUse of  https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#Codelijst-INSPIRE-LimitationsOnPublicAccess
			inhoudelijk niet mogelijk, want de laatste rij van https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#codelist-datalicenties is:
			"Verwijzing naar een geldige URL van de licentie" . Dit is te algemeen, niet testbaar als waarde in een codelijst
		 	-->

			<!-- Veiligheidsrestricties aanscherping-->
			<!--	<sch:let name="classification_value" value="gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints/gmd:MD_SecurityConstraints/gmd:classification/*[@codeListValue = 'unclassified' or @codeListValue = 'restricted' or @codeListValue = 'confidential' or @codeListValue = 'secret' or @codeListValue = 'topSecret']"/>
		-->
		<!-- (Juridische) toegangsrestricties -->
			<!-- aanscherping om public domein CC0 of Geogedeeld te gebruiken -->
			<!-- waarde moet in dat geval otherRestrictions zijn-->
			<!-- Docs: Altijd de 2e set elementen van resourceConstraints, want useLimitation is de 1e (overgenomen uit profiel 1.3) -->
			<sch:let name="accessConstraints_value" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:resourceConstraints[2]/gmd:MD_LegalConstraints/gmd:accessConstraints/*[@codeListValue = 'otherRestrictions']/@codeListValue)"/>

			<!-- Omgrenzende rechthoek https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#omgrenzende-rechthoek -->

			<sch:let name="west" value="number(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement[1]/gmd:EX_GeographicBoundingBox/gmd:westBoundLongitude/gco:Decimal)"/>
			<sch:let name="east" value="number(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement[1]/gmd:EX_GeographicBoundingBox/gmd:eastBoundLongitude/gco:Decimal)"/>
			<sch:let name="north" value="number(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement[1]/gmd:EX_GeographicBoundingBox/gmd:northBoundLatitude/gco:Decimal)"/>
			<sch:let name="south" value="number(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement[1]/gmd:EX_GeographicBoundingBox/gmd:southBoundLatitude/gco:Decimal)"/>

		<!-- Temporele dekking begin -->
			<sch:let name="begin_beginPosition" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/*/gml:beginPosition)"/>
			<sch:let name="begin_begintimePosition" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/*/gml:begin/*/gml:timePosition)"/>
			<sch:let name="begin_timePosition" value="normalize-space(gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/*/gml:timePosition)"/>
		<!-- spatial resolution -->
			<sch:let name="spatialResolution" value="gmd:identificationInfo/gmd:MD_DataIdentification/gmd:spatialResolution"/>
		<!-- reference system  -->
			<sch:let name="referenceSystemInfo" value="gmd:referenceSystemInfo"/>

		<!-- rules and assertions -->
			<!-- Dataset titel, https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#titel-van-de-bron -->
			<sch:assert id="Dataset_titel__ISO_nr._360_" test="$datasetTitle">Dataset titel (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#titel-van-de-bron) ontbreekt</sch:assert>
			<sch:report id="Dataset_titel__ISO_nr._360__info" test="$datasetTitle">Dataset titel (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#titel-van-de-bron): <sch:value-of select="$datasetTitle"/>
			</sch:report>

			<!-- Datum van de bron en Datum type van de bron, https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#datum-van-de-bron en https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#datum-type-van-de-bron-->
			<sch:assert id="Datum_van_de_bron_ISO_nr._394_en_Datumtype__ISO_nr.395_" test="$publicationDate or $creationDate or $revisionDate">Datum van de bron(https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#datum-van-de-bron) of Datumtype (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#datum-type-van-de-bron) ontbreken of heeft het verkeerde formaat (YYYY-MM-DD)</sch:assert>
			<sch:report id="Datum_van_de_bron_ISO_nr._394_en_Datumtype__ISO_nr.395__info" test="$publicationDate or $creationDate or $revisionDate">Tenminste 1 datum van de bron (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#datum-van-de-bron) is gevonden</sch:report>

			<!-- 5.2.5 Samenvatting https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#samenvatting -->
			<sch:assert id="Samenvatting__ISO_nr._25_" test="$abstract">Samenvatting (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#samenvatting) ontbreekt</sch:assert>
			<sch:report id="SSamenvatting__ISO_nr._25__info" test="$abstract">Samenvatting (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#samenvatting): <sch:value-of select="$abstract"/>
			</sch:report>

			<sch:assert id="Status__ISO_nr._28_" test="$status">Status (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#status) ontbreekt of heeft een verkeerde waarde</sch:assert>
			<sch:report id="Status__ISO_nr._28__info" test="$status">Status (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#status) voldoet
			</sch:report>

			<!-- 5.2.10 Verantwoordelijke organisatie bron https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#verantwoordelijke-organisatie-bron -->
			<sch:assert id="Verantwoordelijke_organisatie_bron__ISO_nr._376_" test="$responsibleParty_OrganisationString or $responsibleParty_OrganisationURI">Verantwoordelijke organisatie bron (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#verantwoordelijke-organisatie-bron) ontbreekt</sch:assert>
			<sch:report id="Verantwoordelijke_organisatie_bron__ISO_nr._376__info" test="$responsibleParty_OrganisationString or $responsibleParty_OrganisationURI">Verantwoordelijke organisatie bron (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#verantwoordelijke-organisatie-bron): <sch:value-of select="$responsibleParty_OrganisationString"/> <sch:value-of select="$responsibleParty_OrganisationAnchor"/> (URI: <sch:value-of select="$responsibleParty_OrganisationURI"/>)
			</sch:report>

			<sch:assert id="Rol_verantwoordelijke_organisatie_bron__ISO_nr._379_" test="$responsibleParty_Role">Rol verantwoordelijke organisatie bron (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#verantwoordelijke-organisatie-bron:-rol) ontbreekt of heeft een verkeerde waarde</sch:assert>
			<sch:report id="Rol_verantwoordelijke_organisatie_bron__ISO_nr._379__info" test="$responsibleParty_Role">Rol verantwoordelijke organisatie bron (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#verantwoordelijke-organisatie-bron:-rol) voldoet
			</sch:report>
			<sch:assert id="E-mail_verantwoordelijke_organisatie_bron__ISO_nr._386_" test="$responsibleParty_Mail">E-mail verantwoordelijke organisatie bron (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#verantwoordelijke-organisatie-bron-email) ontbreekt</sch:assert>
			<sch:report id="E-mail_verantwoordelijke_organisatie_bron__ISO_nr._386__info" test="$responsibleParty_Mail">E-mail verantwoordelijke organisatie bron (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#verantwoordelijke-organisatie-bron-email): <sch:value-of select="$responsibleParty_Mail"/>
			</sch:report>
			<sch:assert id="Trefwoorden__ISO_nr._53_" test="$keyword">Trefwoorden (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#trefwoord) ontbreken</sch:assert>
			<sch:report id="Trefwoorden__ISO_nr._53_info" test="$keyword">Tenminste 1 trefwoord (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#trefwoord) is gevonden (<sch:value-of select="$keyword"/>)
			</sch:report>
		<!-- Thesaurus alleen voor INSPIRE-->
		<!--
			<sch:assert id="Thesaurus (ISO nr. 360)" test="$thesaurus_INSPIRE_Exsists">Thesaurus (ISO nr. 360), datum en datumtype ontbreekt</sch:assert>
		-->
		<!-- eind Thesaurus alleen voor INSPIRE-->

		<!-- Als  de GEMET INSPIRE themes thesaurus voorkomt, is verwijzing naar inspire specificatie verplicht -->

		<sch:assert id="Specificatie__ISO_nr._360" test="not($thesaurus_INSPIRE_Exsists) or ($thesaurus_INSPIRE_Exsists and $conformity_Spec_Title_Exsists)">Specificatie (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#thesaurus) mist de verplichte waarde voor INSPIRE datasets. Als dit geen INSPIRE dataset is verwijder dan de thesaurus GEMET -INSPIRE themes, voor INSPIRE datasets in specificatie opnemen; VERORDENING (EU) Nr. 1089/2010 VAN DE COMMISSIE van 23 november 2010 ter uitvoering van Richtlijn 2007/2/EG van het Europees Parlement en de Raad betreffende de interoperabiliteit van verzamelingen ruimtelijke gegevens en van diensten met betrekking tot ruimtelijke gegevens</sch:assert>

		<!-- eind	-->

			<!-- 5.2.4 Unieke Identifier van de bron https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#unieke-identifier-van-de-bron -->
			<sch:assert id="Unieke_Identifier_van_de_bron__ISO_nr._207_" test="$identifierString or $identifierURI">Unieke Identifier van de bron (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#unieke-identifier-van-de-bron) ontbreekt</sch:assert>
			<sch:report id="Unieke_Identifier_van_de_bron__ISO_nr._207__info" test="$identifierString or $identifierURI">Unieke Identifier van de bron (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#unieke-identifier-van-de-bron): <sch:value-of select="$identifierString"/><sch:value-of select="$identifierURI"/>
			</sch:report>

			<!-- conditioneel: dus niet op testen als assertion -->
			<sch:report id="Dataset_taal__ISO_nr._39_info" test="$language">Dataset taal (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#taal-van-de-bron): <sch:value-of select="$language"/>
			</sch:report>

			<!-- 5.2.8 Karakterset van de bron: conditioneel geworden. Geen assertion meer, bevestigd door Ine. https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#karakterset-van-de-bron -->
			<!-- <sch:assert id="Dataset karakterset (ISO nr. 40)" test="not($characterset) or $characterset_value">Dataset karakterset (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#karakterset-van-de-bron) ontbreekt of heeft een verkeerde waarde</sch:assert>
			<sch:report id="Dataset karakterset (ISO nr. 40) info" test="$characterset_value">Dataset karakterset (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#karakterset-van-de-bron) voldoet
			</sch:report> -->

			<!-- 5.2.9 Onderwerp https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#onderwerp -->
			<sch:assert id="Onderwerp_ISO_nr._41_" test="$topicCategory">Onderwerp (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#onderwerp) ontbreekt of heeft een verkeerde waarde</sch:assert>
			<sch:report id="Onderwerp_ISO_nr._41__info" test="$topicCategory">Onderwerp (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#onderwerp) voldoet
			</sch:report>


			<sch:assert id="Minimum_x-coordinaat__ISO_nr._344_"  test="(-180.00 &lt; $west) and ( $west &lt; 180.00) or ( $west = 0.00 ) or ( $west = -180.00 ) or ( $west = 180.00 )">Minimum x-coördinaat (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#omgrenzende-rechthoek) ontbreekt of heeft een verkeerde waarde</sch:assert>
			<sch:report id="Minimum_x-coordinaat__ISO_nr._344__info" test="(-180.00 &lt; $west) and ( $west &lt; 180.00) or ( $west = 0.00 ) or ( $west = -180.00 ) or ( $west = 180.00 )">Minimum x-coördinaat (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#omgrenzende-rechthoek): <sch:value-of select="$west"/>
			</sch:report>
			<sch:assert id="Maximum_x-coordinaat__ISO_nr._345_"  test="(-180.00 &lt; $east) and ($east &lt; 180.00) or ( $east = 0.00 ) or ( $east = -180.00 ) or ( $east = 180.00 )">Maximum x-coördinaat (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#omgrenzende-rechthoek) ontbreekt of heeft een verkeerde waarde</sch:assert>
			<sch:report id="Maximum_x-coordinaat__ISO_nr._345__info"  test="(-180.00 &lt; $east) and ($east &lt; 180.00) or ( $east = 0.00 ) or ( $east = -180.00 ) or ( $east = 180.00 )">Maximum x-coördinaat (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#omgrenzende-rechthoek): <sch:value-of select="$east"/>
			</sch:report>
			<sch:assert id="Minimum_y-coordinaat__ISO_nr._346_" test="(-90.00 &lt; $south) and ($south &lt; $north) or (-90.00 = $south) or ($south = $north)">Minimum y-coördinaat (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#omgrenzende-rechthoek) ontbreekt of heeft een verkeerde waarde</sch:assert>
			<sch:report id="Minimum_y-coordinaat__ISO_nr._346__info" test="(-90.00 &lt; $south) and ($south &lt; $north) or (-90.00 = $south) or ($south = $north)">Minimum y-coördinaat (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#omgrenzende-rechthoek): <sch:value-of select="$south"/>
			</sch:report>
			<sch:assert id="Maximum_y-coordinaat__ISO_nr._347_" test="($south &lt; $north) and ($north &lt; 90.00) or ($south = $north) or ($north = 90.00)">Maximum y-coördinaat (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#omgrenzende-rechthoek) ontbreekt of heeft een verkeerde waarde</sch:assert>
			<sch:report id="Maximum_y-coordinaat__ISO_nr._347__info" test="($south &lt; $north) and ($north &lt; 90.00) or ($south = $north) or ($north = 90.00)">Maximum y-coördinaat (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#omgrenzende-rechthoek): <sch:value-of select="$north"/>
			</sch:report>
			<!-- optineel geworden in v1.3
			<sch:assert id="Temporele dekking - BeginDatum (ISO nr. 351)" test="$begin_beginPosition or $begin_begintimePosition or $begin_timePosition">Temporele dekking - BeginDatum (ISO nr. 351) ontbreekt</sch:assert>
			<sch:report id="Temporele dekking - BeginDatum (ISO nr. 351) info" test="$begin_beginPosition or $begin_begintimePosition or $begin_timePosition">Temporele dekking - BeginDatum (ISO nr. 351): <sch:value-of select="$begin_beginPosition"/><sch:value-of select="$begin_begintimePosition"/><sch:value-of select="$begin_timePosition"/>
			</sch:report>
			 -->

			<sch:assert id="Gebruiksbeperkingen__ISO_nr._68_" test="$useLimitation">Gebruiksbeperkingen (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#gebruiksbeperkingen) ontbreken</sch:assert>
			<sch:report id="Gebruiksbeperkingen__ISO_nr._68__info" test="$useLimitation">Gebruiksbeperkingen (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#gebruiksbeperkingen): <sch:value-of select="$useLimitation"/>
			</sch:report>
			<sch:assert id="Overige_beperkingen_1_Anchor_URI_aanwezig" test="not($otherConstraintURI1) or ($otherConstraintURI1 and $otherConstraintURI1/@xlink:href)">Overige beperkingen eerste element: de URI (xlink:href) dient ingevuld te zijn</sch:assert>
			<sch:assert id="Overige_beperkingen_2_Anchor_URI_aanwezig" test="not($otherConstraintURI2) or ($otherConstraintURI2 and $otherConstraintURI2/@xlink:href)">Overige beperkingen tweede element: de URI (xlink:href) dient ingevuld te zijn</sch:assert>

			<sch:assert id="_Juridische__toegangsrestricties__ISO_nr._70__en_Overige_beperkingen__ISO_nr_72_" test="$accessConstraints_value and $otherConstraints ">(Juridische) toegangsrestricties (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#juridische-toegangsrestricties) en Overige beperkingen (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#overige-beperkingen) dienen ingevuld te zijn</sch:assert>
			<sch:assert id="_Juridische__toegangsrestricties__ISO_nr._70_" test="$accessConstraints_value">(Juridische) toegangsrestricties (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#juridische-toegangsrestricties) dient de waarde 'anders' te hebben in combinatie met een publiek domein, CC0 of GeoGedeeld licentie bij overige beperkingen (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#overige-beperkingen)</sch:assert>
			<sch:assert id="Overige_beperkingen__ISO_nr_72_" test="not($accessConstraints_value = 'otherRestrictions') or ($accessConstraints_value = 'otherRestrictions' and $otherConstraint1 and $otherConstraint2)">Het element overige beperkingen (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#overige-beperkingen) dient twee maal binnen dezelfde toegangsrestricties voor te komen; één met de beschrijving en één met de URL naar de publiek domein, CC0 of GeoGedeeld licentie,als (juridische) toegangsrestricties (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#juridische-toegangsrestricties) de waarde 'anders' heeft</sch:assert>
			<sch:report id="Overige_beperkingen__ISO_nr_72__1_info" test="$otherConstraint1">Overige beperkingen (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#overige-beperkingen) 1: <sch:value-of select="$otherConstraint1"/>
			</sch:report>
			<sch:report id="Overige_beperkingen__ISO_nr_72_2_info" test="$otherConstraint2">Overige beperkingen (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#overige-beperkingen) 2: <sch:value-of select="$otherConstraint2"/>
			</sch:report>

			<sch:report id="_Juridische__toegangsrestricties__ISO_nr._70__info"  test="$accessConstraints_value">(Juridische) toegangsrestricties (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#juridische-toegangsrestricties) aanwezig: <sch:value-of select="$accessConstraints_value"/>
			</sch:report>

			<!-- Thijs Brentjens: nieuwe controle op codelijst https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#codelist-datalicenties -->
			<sch:assert id="Overige_beperkingen_en_codelijst_Datalicenties" test="not($accessConstraints_value = 'otherRestrictions') or ($accessConstraints_value = 'otherRestrictions' and $otherConstraintIsCodelistdatalicense)">Als het element juridische toegangsrestricties de waarde otherRestrictions bevat dient een link uit de codelijst https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#codelist-datalicenties naar de licentie en de bijbehorende beschrijving opgenomen te worden. Opgenomen informatie: <sch:value-of select="$otherConstraint1"/> met licentie:<sch:value-of select="$otherConstraintURI1/@xlink:href"/> <sch:value-of select="$otherConstraint2"/> en <sch:value-of select="$otherConstraint2"/> <sch:value-of select="$otherConstraintURI2/@xlink:href"/> <sch:value-of select="$otherConstraint1"/></sch:assert>

			<!-- <sch:report id="Datalicenties info" test="not($accessConstraints_value = 'otherRestrictions') and not($accessConstraints_value = 'otherRestrictions' and $otherConstraintIsCodelistdatalicense)"><sch:value-of select="$otherConstraint1"/> met licentie:<sch:value-of select="$otherConstraintURI1/@xlink:href"/><sch:value-of select="$otherConstraint2"/> en <sch:value-of select="$otherConstraint2"/> <sch:value-of select="$otherConstraintURI2/@xlink:href"/><sch:value-of select="$otherConstraint1"/></sch:report> -->

			<sch:assert id="Toepassingsschaal__ISO_nr._57__Resolutie__ISO_nr._61_" test="$spatialResolution">Toepassingsschaal (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#toepassingsschaal) of Resolutie (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#resolutie) is verplicht als hij gespecificeerd kan worden. </sch:assert>

			<sch:assert id="Code_referentiesysteem__ISO_nr._207_" test="$referenceSystemInfo">Code referentiesysteem (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#codereferentiesysteem) ontbreekt</sch:assert>

		<!-- alle regels over elementen binnen distributionInfo -->

			<sch:let name="distributionFormatName" value="normalize-space(gmd:distributionInfo/gmd:MD_Distribution/gmd:distributionFormat/gmd:MD_Format/gmd:name/gco:CharacterString)"/>
			<sch:let name="distributionFormatVersion" value="normalize-space(gmd:distributionInfo/gmd:MD_Distribution/gmd:distributionFormat/gmd:MD_Format/gmd:version/gco:CharacterString)"/>
			<sch:let name="distributionFormatSpecification" value="normalize-space(gmd:distributionInfo/gmd:MD_Distribution/gmd:distributionFormat/gmd:MD_Format/gmd:specification/gco:CharacterString)"/>

		<!-- Naam distributie formaat, distributie format voor INSPIRE geharmoniseerd https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#naam-distributie-formaat -->
		<!-- Anchor, maar alleen voor INSPIRE geharmoniseerd verplicht  -->
		<!--
			<sch:assert id="Naam distributie formaat (ISO nr. 285)" test="$distributionFormatName">Naam distributie formaat (ISO nr. 285) ontbreekt</sch:assert>
			<sch:report id="Naam distributie formaat (ISO nr. 285) info" test="$distributionFormatName">Naam distributie formaat (ISO nr. 285): <sch:value-of select="$distributionFormatName"/>
		</sch:report> -->
			<!-- Versie distributie formaat, https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#versie-distributie-formaat -->
			<!--
			<sch:assert id="Versie distributie formaat (ISO nr. 286)" test="$distributionFormatVersion">Versie distributie formaat (ISO nr. 286) ontbreekt</sch:assert>
			<sch:report id="Versie distributie formaat (ISO nr. 286) info" test="$distributionFormatVersion">Versie distributie formaat (ISO nr. 286): <sch:value-of select="$distributionFormatVersion"/>
		</sch:report>  -->
		<!-- Specificatie distributie formaat https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#specificatie-distributie-formaat -->
		<!-- Anchor, maar alleen voor INSPIRE geharmoniseerd verplicht  -->
		<!--
			<sch:assert id="Specificatie distributie formaat (ISO nr. 288)" test="$distributionFormatSpecification">Specificatie distributie formaat (ISO nr. 288) ontbreekt</sch:assert>
			<sch:report id="Specificatie distributie formaat (ISO nr. 288) info" test="$distributionFormatSpecification">Specificatie distributie formaat (ISO nr. 288): <sch:value-of select="$distributionFormatSpecification"/>
			</sch:report>
		-->
		<!-- eind distributie format voor INSPIRE geharmoniseerd -->


	  <!-- Thijs: om fouten in de validator te voorkomen als er metadata is aangeleverd met meerdere blokken dataQualityInfo (de NGR editor kan dit soort fouten veroorzaken), gebruik altijd alleen het eerste blok. Doe dit bij alle elementen gmd:dataQualityInfo -->
		<!-- alle regels over elementen binnen gmd:dataQualityInfo -->
			<sch:let name="dataQualityInfo" value="gmd:dataQualityInfo[1]/gmd:DQ_DataQuality"/>
		<!-- Algemene beschrijving herkomst, https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#algemene-beschrijving-herkomst  -->
			<sch:let name="statement" value="normalize-space($dataQualityInfo/gmd:lineage/gmd:LI_Lineage/gmd:statement/gco:CharacterString)"/>

		<!--  Niveau kwaliteitsbeschrijving, https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#niveau-kwaliteitsbeschrijving -->
			<sch:let name="level" value="string($dataQualityInfo/gmd:scope/gmd:DQ_Scope/gmd:level/*/@codeListValue[. = 'dataset' or . = 'series'])"/>
		<!-- rules and assertions -->
			<sch:assert id="Algemene_beschrijving_herkomst__ISO_nr._83_" test="$statement">Algemene beschrijving herkomst (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#algemene-beschrijving-herkomst) ontbreekt</sch:assert>
			<sch:report id="Algemene_beschrijving_herkomst__ISO_nr._83__info" test="$statement">Algemene beschrijving herkomst (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#algemene-beschrijving-herkomst): <sch:value-of select="$statement"/>
			</sch:report>
			<sch:assert id="Niveau_kwaliteitsbeschrijving__ISO_nr.139_" test="$level">Niveau kwaliteitsbeschrijving (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#niveau-kwaliteitsbeschrijving) ontbreekt</sch:assert>
			<sch:report id="Niveau_kwaliteitsbeschrijving__ISO_nr.139__info" test="$level">Niveau kwaliteitsbeschrijving (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#niveau-kwaliteitsbeschrijving): <sch:value-of select="$level"/>
			</sch:report>

		</sch:rule>


		<!-- URL  naar een service -->

		 <sch:rule id="INSPIRE_Online_toegang_tot_de_bron" context="//gmd:MD_Metadata/gmd:distributionInfo/gmd:MD_Distribution/gmd:transferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine/gmd:CI_OnlineResource">
			 <sch:let name="all_transferOptions_URL" value="ancestor::gmd:MD_DigitalTransferOptions/gmd:onLine/gmd:CI_OnlineResource/gmd:linkage"/>

			 <!-- URL voor INSPIRE in combi met specificatie INSPIRE -->
		 	<sch:assert id="URL__ISO_nr._397_" test="not($conformity_Spec_Title_Exsists) or ($conformity_Spec_Title_Exsists and $all_transferOptions_URL[normalize-space(*/text())])">URL (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#url) onbreekt, voor INSPIRE is de link naar de gerelateerde services (view en download) verplicht.</sch:assert>

		<!-- eind  URL voor INSPIRE  -->
		</sch:rule>


		<!-- regels voor meerdere transfer options-->
		<!-- conditioneel -->
		<sch:rule id="Online_toegang_tot_de_bron" context="//gmd:MD_Metadata/gmd:distributionInfo/gmd:MD_Distribution/gmd:transferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine">
		<!-- URL, https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#url -->
			<sch:let name="transferOptions_URL" value="normalize-space(gmd:CI_OnlineResource/gmd:linkage/gmd:URL)"/>
		<!-- Protocol https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#protocol -->
		<!-- TODO: Ook de URIs voor Anchors inbouwen of niet?
		MediaType
		Protocol
	 	-->
			<sch:let name="transferOptions_Protocol" value="gmd:CI_OnlineResource/gmd:protocol/*[text() = 'OGC:CSW' or text() = 'OGC:WMS' or text() = 'OGC:WMTS' or text() = 'OGC:WFS' or text() = 'OGC:WCS' or text() = 'OGC:WCTS' or text() = 'OGC:WPS' or text() = 'UKST' or text() = 'INSPIRE Atom' or text() = 'OGC:WFS-G' or text() = 'OGC:SOS' or text() = 'OGC:SPS' or text() = 'OGC:SAS' or text() = 'OGC:WNS' or text() = 'OGC:ODS' or text() = 'OGC:OGS' or text() = 'OGC:OUS' or text() = 'OGC:OPS' or text() = 'OGC:ORS' or text() = 'OGC:SensorThings' or text() = 'W3C:SPARQL' or text() = 'OASIS:OData' or text() = 'OAS' or text() = 'landingpage'  or text() = 'dataset' or text() = 'application' or text() = 'UKST' ]"/>

			<!-- Mediatypes: https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#codelist-mediatypes -->
			<sch:let name="transferOptions_Mediatype" value="gmd:CI_OnlineResource/gmd:protocol/*[translate(text(), $uppercase, $lowercase) = 'gml' or translate(text(), $uppercase, $lowercase) = 'kml' or translate(text(), $uppercase, $lowercase) = 'geojson' or translate(text(), $uppercase, $lowercase) = 'gpkg' or translate(text(), $uppercase, $lowercase) = 'json' or translate(text(), $uppercase, $lowercase) = 'jsonld' or translate(text(), $uppercase, $lowercase) = 'rdf-xml' or translate(text(), $uppercase, $lowercase) = 'xml' or translate(text(), $uppercase, $lowercase) = 'zip' or translate(text(), $uppercase, $lowercase) = 'png' or translate(text(), $uppercase, $lowercase) = 'png' or translate(text(), $uppercase, $lowercase) = 'gif' or translate(text(), $uppercase, $lowercase) = 'jp2' or translate(text(), $uppercase, $lowercase) = 'tiff' or translate(text(), $uppercase, $lowercase) = 'csv' or translate(text(), $uppercase, $lowercase) = 'mapbox-vector-tile']"/>

			<sch:let name="transferOptions_Protocol_isOGCService" value="gmd:CI_OnlineResource/gmd:protocol/*[text() = 'OGC:WMS' or text() = 'OGC:WFS' or text() = 'OGC:WCS' or text() = 'INSPIRE Atom']"/>
		<!-- Naam https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#naam -->
			<sch:let name="transferOptions_Name" value="normalize-space(gmd:CI_OnlineResource/gmd:name/gco:CharacterString)"/>

		<!-- Omschrijving, https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#description
		Dit is conditioneel, dus opletten: Het is verplicht als er een URL van het type 'endPoint' is opgegeven.
		Kan een Anchor zijn.
		Bij een URL van het type 'accessPoint' kan het element leeg gelaten worden. Aanname is dat als er geen waarde is opgegeven, het een accessPoint is.
		Dit betekent dat er feitelijk niet getest kan worden op aanwezigheid: het ontbreken van het element is namelijk ook correct.
		-->
			<sch:let name="transferOptions_Description_Value" value="normalize-space(gmd:CI_OnlineResource/gmd:description[./gco:CharacterString or ./gmx:Anchor]/*[name() != 'geonet:element'])"/>

<!-- [string-length(normalize-space(text())) > 0] -->

		<!-- asssertions and report -->
			<sch:assert id="Protocol__ISO_nr._398__verplicht_bij_URL__ISO_nr._397_" test="not($transferOptions_URL) or ($transferOptions_URL and ($transferOptions_Protocol or $transferOptions_Mediatype))">Protocol (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#protocol) is verplicht als URL (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#url) is ingevuld.</sch:assert>
			<sch:assert id="URL__ISO_nr._397__en_Protocol__ISO_nr._398_" test="not($transferOptions_Protocol or $transferOptions_Mediatype) or (($transferOptions_Protocol or $transferOptions_Mediatype) and $transferOptions_URL)">Protocol (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#protocol) alleen opnemen als URL (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#url) is ingevuld.</sch:assert>
			<sch:report id="URL__ISO_nr._397__info" test="$transferOptions_URL"> URL (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#url): <sch:value-of select="$transferOptions_URL"/>
			</sch:report>
			<sch:report id="Protocol__ISO_nr._398__info" test="$transferOptions_Protocol or $transferOptions_Mediatype">Protocol (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#protocol): <sch:value-of select="gmd:CI_OnlineResource/gmd:protocol/*/text()"/>
			</sch:report>
			<sch:assert id="Naam__ISO_nr._400_" test="not($transferOptions_Protocol_isOGCService) or ($transferOptions_Protocol_isOGCService and $transferOptions_Name)">Naam (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#naam) is verplicht als Protocol (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#protocol) de waarde OGC:WMS, OGC:WFS, OGC:WCS of INSPIRE Atom heeft.</sch:assert>
			<sch:report id="Naam__ISO_nr._400__info" test="$transferOptions_Name">Naam (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#naam) is : <sch:value-of select="$transferOptions_Name"/>
			</sch:report>

			<!-- Thijs Brentjens: nieuwe assertion. Als de URL een endpoint is, moet de codelijst https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#codelist-mediatypes gebruikt worden. Bij een accessPoint de codelijst https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#codelist-protocol-->
			<sch:assert id="Bij_een_URL_endPoint_moet_een_waarde_uit_de_codelijst_mediatype_opgegeven_zijn" test="not($transferOptions_Description_Value = 'endPoint') or ($transferOptions_Description_Value = 'endPoint' and $transferOptions_Mediatype)">Protocol (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#protocol) moet een waarde uit de codelijst media types (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#codelist-mediatypes) bevatten als de URL omschrijving (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#Codelist-INSPIRE-OnLineDescriptionCode) een endPoint is.</sch:assert>
			<sch:assert id="Bij_een_URL_accessPoint_moet_een_waarde_uit_de_codelijst_protocol_opgegeven_zijn" test="not($transferOptions_Description_Value = 'accessPoint') or ($transferOptions_Description_Value = 'accessPoint' and $transferOptions_Protocol)">Protocol (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#protocol) moet een waarde uit de codelijst protocol (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#codelist-protocol) bevatten als de URL omschrijving (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#Codelist-INSPIRE-OnLineDescriptionCode) een accessPoint is.</sch:assert>

		</sch:rule>

		<!-- Nieuw: codelijst protocol apart testen -->
		<!-- TODO: codelijst check moet niet-hoofdlettergevoelig zijn ?
		Let op de manier van de codelijst checken, zie ook mediatype: alles naar kleine letters omschrijven
		-->
		<sch:rule id="Codelijst_protocol" context="//gmd:CI_OnlineResource/gmd:protocol/gmx:Anchor[text() = 'OGC:CSW' or text() = 'OGC:WMS' or text() = 'OGC:WMTS' or text() = 'OGC:WFS' or text() = 'OGC:WCS' or text() = 'OGC:WCTS' or text() = 'OGC:WPS' or text() = 'UKST' or text() = 'INSPIRE Atom' or text() = 'OGC:WFS-G' or text() = 'OGC:SOS' or text() = 'OGC:SPS' or text() = 'OGC:SAS' or text() = 'OGC:WNS' or text() = 'OGC:ODS' or text() = 'OGC:OGS' or text() = 'OGC:OUS' or text() = 'OGC:OPS' or text() = 'OGC:ORS' or text() = 'OGC:SensorThings' or text() = 'W3C:SPARQL' or text() = 'OASIS:OData' or text() = 'OAS' or text() = 'landingpage'  or text() = 'dataset' or text() = 'application' or text() = 'UKST']">

			<sch:let name="anchorUri" value="normalize-space(@xlink:href)"/>
			<sch:let name="txt" value="normalize-space(text())"/>
			<sch:let name="combination" value="concat($anchorUri, '=', $txt)"/>
			<sch:let name="codelist" value="'http://www.opengeospatial.org/standards/cat=OGC:CSW, http://www.opengeospatial.org/standards/wms=OGC:WMS, http://www.opengeospatial.org/standards/wmts=OGC:WMTS, http://www.opengeospatial.org/standards/wfs=OGC:WFS, http://www.opengeospatial.org/standards/wcs=OGC:WCS, http://www.opengeospatial.org/standards/sos=OGC:SOS, =INSPIRE Atom, http://www.opengeospatial.org/standards/=OGC:WCTS, http://www.opengeospatial.org/standards/wps=OGC:WPS, =OGC:WFS-G, http://www.opengeospatial.org/standards/sps=OGC:SPS, http://www.ogcnetwork.net/SAS=OGC:SAS, =OGC:WNS, http://www.opengeospatial.org/standards/ols#ODS=OGC:ODS, http://www.opengeospatial.org/standards/ols#OGS=OGC:OGS, http://www.opengeospatial.org/standards/ols#OUS=OGC:OUS, http://www.opengeospatial.org/standards/ols#OPS=OGC:OPS, http://www.opengeospatial.org/standards/ols#ORS=OGC:ORS, http://www.opengeospatial.org/standards/sensorthings=OGC:SensorThings, https://www.w3.org/TR/rdf-sparql-query/=W3C:SPARQL, https://www.oasis-open.org/committees/odata=OASIS:OData, https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md=OAS, =landingpage, =application, =dataset, =UKST'" />

			<sch:assert id="Codelijst_protocol__geldige_combinatie_van_URI_en_waarde" test="contains($codelist, $combination)">De combinatie van de URI '<sch:value-of select="$anchorUri"/>' en waarde '<sch:value-of select="$txt"/>' is geen geldige combinatie uit de codelijst protocol https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#codelist-protocol</sch:assert>

		</sch:rule>


		<sch:rule id="Codelijst_media_types" context="//gmd:CI_OnlineResource/gmd:protocol/gmx:Anchor[translate(text(), $uppercase, $lowercase) = 'gml' or translate(text(), $uppercase, $lowercase) = 'kml' or translate(text(), $uppercase, $lowercase) = 'geojson' or translate(text(), $uppercase, $lowercase) = 'gpkg' or translate(text(), $uppercase, $lowercase) = 'json' or translate(text(), $uppercase, $lowercase) = 'jsonld' or translate(text(), $uppercase, $lowercase) = 'rdf-xml' or translate(text(), $uppercase, $lowercase) = 'xml' or translate(text(), $uppercase, $lowercase) = 'zip' or translate(text(), $uppercase, $lowercase) = 'png' or translate(text(), $uppercase, $lowercase) = 'png' or translate(text(), $uppercase, $lowercase) = 'gif' or translate(text(), $uppercase, $lowercase) = 'jp2' or translate(text(), $uppercase, $lowercase) = 'tiff' or translate(text(), $uppercase, $lowercase) = 'csv' or translate(text(), $uppercase, $lowercase) = 'mapbox-vector-tile']">
			<sch:let name="anchorUri" value="normalize-space(translate(@xlink:href, $uppercase, $lowercase))"/>
			<sch:let name="txt" value="normalize-space(translate(text(), $uppercase, $lowercase))"/>
			<sch:let name="combination" value="concat($anchorUri, '=', $txt)"/>
			<sch:let name="codelist" value="'https://www.iana.org/assignments/media-types/application/gml+xml=gml, http://www.iana.org/assignments/media-types/application/vnd.google-earth.kml+xml=kml, https://www.iana.org/assignments/media-types/application/geo+json=geojson, http://inspire.ec.europa.eu/media-types/application/x-sqlite3=gpkg, https://www.iana.org/assignments/media-types/application/json=json, https://www.iana.org/assignments/media-types/application/ld+json=jsonld, https://www.iana.org/assignments/media-types/application/rdf+xml=rdf-xml, https://www.iana.org/assignments/media-types/application/xml=xml, https://www.iana.org/assignments/media-types/application/zip=zip, https://www.iana.org/assignments/media-types/image/png=png, https://www.iana.org/assignments/media-types/image/gif=gif, https://www.iana.org/assignments/media-types/image/jp2=jp2, https://www.iana.org/assignments/media-types/image/tiff=tiff, https://www.iana.org/assignments/media-types/text/csv=csv, https://www.iana.org/assignments/media-types/application/vnd.mapbox-vector-tile=mapbox-vector-tile'" />

			<sch:assert id="Codelijst_media_types__geldige_combinatie_van_URI_en_waarde" test="contains($codelist, $combination)">De combinatie van de URI '<sch:value-of select="$anchorUri"/>' en waarde '<sch:value-of select="$txt"/>' is geen geldige combinatie uit de codelijst media types https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#codelist-mediatypes</sch:assert>
		</sch:rule>

		<sch:rule id="Codelijst_INSPIRE_OnLineDescriptionCode" context="//gmd:CI_OnlineResource/gmd:description/gmx:Anchor">
			<sch:let name="anchorUri" value="normalize-space(translate(@xlink:href, $uppercase, $lowercase))"/>
			<sch:let name="txt" value="normalize-space(translate(text(), $uppercase, $lowercase))"/>
			<sch:let name="combination" value="concat($anchorUri, '=', $txt)"/>
			<!-- NB: lowercase -->
			<sch:let name="codelist" value="'http://inspire.ec.europa.eu/metadata-codelist/onlinedescriptioncode/endpoint=endpoint, http://inspire.ec.europa.eu/metadata-codelist/onlinedescriptioncode/accesspoint=accesspoint'" />

			<sch:assert id="Codelijst_INSPIRE_OnLineDescriptionCode__geldige_combinatie_van_URI_en_waarde" test="contains($codelist, $combination)">De combinatie van de URI '<sch:value-of select="$anchorUri"/>' en waarde '<sch:value-of select="$txt"/>' is geen geldige combinatie uit de codelijst INSPIRE OnLineDescriptionCode https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#Codelist-INSPIRE-OnLineDescriptionCode</sch:assert>

		</sch:rule>

		<!--  Conformiteitindicatie meerdere specificaties -->
		<sch:rule id="Conformiteit_specificaties" context="//gmd:MD_Metadata/gmd:dataQualityInfo[1]/gmd:DQ_DataQuality/gmd:report/gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult">

		<!-- Specificatie title, https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#specificatie
	 	TODO: check of URI ook bij andere tests voor conformity_SpecTitle nodig is, of dat het zo volstaat -->
			<sch:let name="conformity_SpecTitle" value="normalize-space(gmd:specification/gmd:CI_Citation/gmd:title[./gco:CharacterString or ./gmx:Anchor]/*[name() != 'geonet:element'])"/>
			<sch:let name="conformity_SpecTitleString" value="normalize-space(gmd:specification/gmd:CI_Citation/gmd:title/gco:CharacterString)"/>
			<sch:let name="conformity_SpecTitleURI" value="normalize-space(gmd:specification/gmd:CI_Citation/gmd:title/gmx:Anchor/@xlink:href)"/>
		<!-- Verklaring https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#verklaring -->
			<sch:let name="conformity_Explanation" value="normalize-space(gmd:explanation/gco:CharacterString)"/>

		<!-- Specificatie date https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#specificatiedatum	-->
			<sch:let name="conformity_DateString" value="string(gmd:specification/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:date/gco:Date)"/>
			<sch:let name="conformity_Date" value="((number(substring(substring-before($conformity_DateString,'-'),1,4)) &gt; 1000 ))"/>

			<!-- Specificatiedatum type https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#specificatiedatum-type -->
			<!-- Codelijst: https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#codelist-datetypecode -->
			<sch:let name="conformity_Datetype" value="gmd:specification/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:dateType/*[@codeListValue='creation' or @codeListValue='publication' or @codeListValue='revision']"/>
			<sch:let name="conformity_SpecCreationDate" value="gmd:specification/gmd:CI_Citation/gmd:date[./gmd:CI_Date/gmd:dateType/*/@codeListValue='creation']/*/gmd:date/gco:Date"/>
			<sch:let name="conformity_SpecPublicationDate" value="gmd:specification/gmd:CI_Citation/gmd:date[./gmd:CI_Date/gmd:dateType/*/@codeListValue='publication']/*/gmd:date/gco:Date"/>
			<sch:let name="conformity_SpecRevisionDate" value="gmd:specification/gmd:CI_Citation/gmd:date[./gmd:CI_Date/gmd:dateType/*/@codeListValue='revision']/*/gmd:date/gco:Date"/>

			<!-- Conformiteit indicatie met de specificatie https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#conformiteit-indicatie-met-de-specificatie -->
			<sch:let name="conformity_Pass" value="normalize-space(gmd:pass/gco:Boolean)"/>

		<!-- Specificatie alleen voor INSPIRE-->
			<!--
			<sch:assert id="INSPIRE Specificatie (ISO nr. 360 )" test="$conformity_SpecTitle">Specificatie (ISO nr. 360 ) ontbreekt.</sch:assert>
			<sch:assert id="INSPIRE Verklaring (ISO nr. 131)" test="$conformity_Explanation">Verklaring (ISO nr. 131) ontbreekt.</sch:assert>
			<sch:assert id="INSPIRE Specificatie datum (ISO nr. 394" test="$conformity_Date">Specificatie datum (ISO nr. 394) ontbreekt.</sch:assert>
			<sch:assert id="INSPIRE Specificatiedatum type (ISO nr. 395)" test="$conformity_Datetype">Specificatiedatum type (ISO nr. 395) ontbreekt.</sch:assert>
			<sch:assert id="INSPIRE Conformiteitindicatie met de specificatie  (ISO nr. 132)" test="$conformity_Pass">Conformiteitindicatie met de specificatie  (ISO nr. 132) ontbreekt.</sch:assert>

		-->
		<!-- eind Specificatie alleen voor INSPIRE-->

		<!-- Voor niet INSPIRE data als title is ingevuld, moeten date, datetype, explanation en pass ingevuld zijn -->

			<sch:assert id="Verklaring__ISO_nr._131__en_Specificatie__ISO_nr._360_" test="not($conformity_SpecTitle) or ($conformity_SpecTitle and $conformity_Explanation)">Verklaring (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#verklaring) is verplicht als een specificatie (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#specificatie) is opgegeven.</sch:assert>
			<sch:assert id="Datum_ISO_nr._394__en_Specificatie__ISO_nr._360_" test="not($conformity_SpecTitle and not($conformity_Date))">Datum (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#specificatiedatum) is verplicht als een specificatie (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#specificatie) is opgegeven. </sch:assert>
			<sch:assert id="Datumtype__ISO_nr._395___en_Specificatie__ISO_nr._360_" test="not($conformity_SpecTitle and not($conformity_Datetype))">Datumtype (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#specificatiedatum-type) is verplicht als een specificatie (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#specificatie) is opgegeven. </sch:assert>
			<sch:assert id="Conformiteit__ISO_nr._132___en_Specificatie__ISO_nr._360_" test="not($conformity_SpecTitle) or ($conformity_SpecTitle and $conformity_Pass)">Conformiteit (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#conformiteit-indicatie-met-de-specificatie) is verplicht als een specificatie (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#specificatie) is opgegeven.</sch:assert>


		<!-- als er geen titel is ingevuld, moeten date, datetype explanation en pass leeg zijn -->
			<sch:assert id="Verklaring__ISO_nr._131_" test="not($conformity_Explanation) or ($conformity_Explanation and $conformity_SpecTitle)">Verklaring (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#verklaring) hoort leeg te zijn als geen specificatie is opgegeven</sch:assert>
			<sch:assert id="Datum__ISO_nr._394_" test="not($conformity_Date and not($conformity_SpecTitle))">Datum (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#specificatiedatum) hoort leeg te zijn als geen specificatie is opgegeven. </sch:assert>
			<sch:assert id="Datumtype__ISO_nr._395_" test="not($conformity_Datetype and not($conformity_SpecTitle))">Datumtype (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#specificatiedatum-type) hoort leeg te zijn als geen specificatie is opgegeven.</sch:assert>
			<sch:assert id="Conformiteit__ISO_nr._132_" test="not($conformity_Pass) or ($conformity_Pass and $conformity_SpecTitle)">Conformiteit (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#conformiteit-indicatie-met-de-specificatie) hoort leeg te zijn als geen specificatie is opgegeven.</sch:assert>

			<sch:report id="Verklaring__ISO_nr._131__info" test="$conformity_Explanation">Verklaring (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#verklaring): <sch:value-of select="$conformity_Explanation"/>
			</sch:report>
			<sch:report id="Conformiteitindicatie_met_de_specificatie__ISO_nr._132__info" test="$conformity_Pass">Conformiteitindicatie met de specificatie (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#conformiteit-indicatie-met-de-specificatie): <sch:value-of select="$conformity_Pass"/>
			</sch:report>
			<sch:report id="Specificatie__ISO_nr._360__info" test="$conformity_SpecTitleString or $conformity_SpecTitleURI">Specificatie (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#specificatie): <sch:value-of select="$conformity_SpecTitleString"/><sch:value-of select="$conformity_SpecTitleURI"/>
			</sch:report>
			<sch:report id="Datum__ISO_nr._394__en_datum_type__ISO_nr._395__info" test="$conformity_SpecCreationDate or $conformity_SpecPublicationDate or $conformity_SpecRevisionDate">Datum (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#specificatiedatum) en datum type (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#specificatiedatum-type) zijn aanwezig voor specificatie.</sch:report>
		</sch:rule>

		<!-- INSPIRE specification titel -->
		<!--
			<sch:rule id="INSPIRE specificaties" context="//gmd:MD_Metadata/gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:report/gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation">

		    <sch:let name="all_conformity_Spec_Titles" value="ancestor::gmd:DQ_DataQuality/gmd:report/gmd:DQ_DomainConsistency/gmd:result/gmd:DQ_ConformanceResult/gmd:specification/gmd:CI_Citation/gmd:title"/>

			<sch:let name="INSPIRE_conformity_Spec_Title" value="normalize-space(gmd:title/gco:CharacterString)"/>

				<sch:assert id="INSPIRE Specificatie (ISO nr. 360) titel" test="$all_conformity_Spec_Titles[normalize-space(gco:CharacterString/text()) =  'VERORDENING (EU) Nr. 1089/2010 VAN DE COMMISSIE van 23 november 2010 ter uitvoering van Richtlijn 2007/2/EG van het Europees Parlement en de Raad betreffende de interoperabiliteit van verzamelingen ruimtelijke gegevens en van diensten met betrekking tot ruimtelijke gegevens']">Specificatie (ISO nr. 360) verwijst niet naar de VERORDENING (EU) Nr. 1089/2010 VAN DE COMMISSIE van 23 november 2010 ter uitvoering van Richtlijn 2007/2/EG van het Europees Parlement en de Raad betreffende de interoperabiliteit van verzamelingen ruimtelijke gegevens en van diensten met betrekking tot ruimtelijke gegevens</sch:assert>
				<sch:report id="INSPIRE Specificatie (ISO nr. 360) titel info" test="$INSPIRE_conformity_Spec_Title">Specificatie titel (ISO nr. 360) is: <sch:value-of select="$INSPIRE_conformity_Spec_Title"/></sch:report>

			</sch:rule>
		-->
		<!-- eind  INSPIRE specification titel -->


   		<!-- Resolutie en toepassingschaal -->
		<sch:rule id="Resolutie_en_toepassingschaal" context="//gmd:identificationInfo/gmd:MD_DataIdentification">
       			<sch:let name="distance" value="gmd:spatialResolution/gmd:MD_Resolution/gmd:distance/*/text()"/>
       			<sch:let name="denominator" value="gmd:spatialResolution/gmd:MD_Resolution/gmd:equivalentScale/gmd:MD_RepresentativeFraction/gmd:denominator/*/text()"/>

			<sch:assert id="Toepassingsschaal__ISO_nr._57__of_Resolutie__ISO_nr._61_" test="$denominator or $distance ">Toepassingsschaal (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#toepassingsschaal) of Resolutie (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#resolutie) ontbreekt, vul een van deze in</sch:assert>
			<sch:assert id="Toepassingsschaal__ISO_nr._57__en_Resolutie__ISO_nr._61_" test="not($denominator and  $distance) ">Toepassingsschaal (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#toepassingsschaal) of Resolutie (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#resolutie) invullen, niet beide</sch:assert>
       		</sch:rule>

		<!-- Spatial resolution equivalentScale https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#toepassingsschaal -->
		<sch:rule id="Toepassingsschaal" context="//gmd:spatialResolution/gmd:MD_Resolution/gmd:equivalentScale/gmd:MD_RepresentativeFraction/gmd:denominator/gco:Integer">
			<sch:let name="denominator" value="text()"/>
			<sch:assert id="Toepassingsschaal__ISO_nr._57_" test="not(string(number($denominator))='NaN')">Toepassingsschaal (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#toepassingsschaal) heeft een verkeerde waarde, toepassingsschaal is niet numeriek of is leeg.</sch:assert>

			<sch:report id="Toepassingsschaal__ISO_nr._57__info" test="$denominator">Toepassingsschaal (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#toepassingsschaal): <sch:value-of select="$denominator"/>
			</sch:report>
		</sch:rule>

		<!-- Spatial resolution distance https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#resolutie -->
		<sch:rule id="Resolutie" context="//gmd:spatialResolution/gmd:MD_Resolution/gmd:distance/gco:Distance">

			<sch:let name="distance" value="text()"/>
			<sch:let name="distance_UOM" value="@uom= 'meters' "/>

			<sch:assert id="Resolutie__ISO_nr._61_" test="not(string(number($distance))='NaN')">Resolutie (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#resolutie) heeft een verkeerde waarde, resolutie is niet numeriek of is leeg</sch:assert>
			<sch:report id="Resolutie__ISO_nr._61__info" test="$distance">Resolutie (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#resolutie) is: <sch:value-of select="$distance"/>
			</sch:report>

			<sch:assert id="Resolutie__ISO_nr._61__meeteenheid" test="$distance_UOM">Resolutie (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#resolutie) heeft geen of een verkeerde waarde voor Unit of measure, de waarde moet meters zijn.</sch:assert>
			<sch:report id="Resolutie__ISO_nr._61__meeteenheid_info" test="$distance_UOM">Unit of measure voor Resolutie (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#resolutie): <sch:value-of select="$distance_UOM"/>
			</sch:report >
		</sch:rule>


		<!-- Referentiesysteem  -->
		<sch:rule id="Referentiesysteem" context="//gmd:MD_Metadata/gmd:referenceSystemInfo/gmd:MD_ReferenceSystem">
			<!--  Ruimtelijk referentiesysteem  https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#codereferentiesysteem -->
			<!-- RS_Identifier -->
			<sch:let name="referenceSystemInfo_CodeString" value="normalize-space(gmd:referenceSystemIdentifier/gmd:RS_Identifier/gmd:code/gco:CharacterString)"/>
			<sch:let name="referenceSystemInfo_CodeURI" value="normalize-space(gmd:referenceSystemIdentifier/gmd:RS_Identifier/gmd:code/gmx:Anchor[string-length(normalize-space(string-join(text(), ''))) > 0]/@xlink:href)"/>

			<sch:assert id="Code_referentiesysteem__ISO_nr._207__" test="$referenceSystemInfo_CodeString or $referenceSystemInfo_CodeURI">Code referentiesysteem (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#codereferentiesysteem) waarde en/of URI ontbreekt</sch:assert>
			<sch:report id="Code_referentiesysteem__ISO_nr._207___info" test="$referenceSystemInfo_CodeString or $referenceSystemInfo_CodeURI">Code referentiesysteem (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#codereferentiesysteem): <sch:value-of select="$referenceSystemInfo_CodeString"/> <sch:value-of select="$referenceSystemInfo_CodeURI"/>
			</sch:report>

		</sch:rule>

        <!-- Tests rondom Thesauri Controlled originating vocabulary, https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#thesaurus e.v. -->
		<sch:rule id="Thesaurus" context="//gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation">

			<!-- 5.2.14 Thesaurus title, https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#thesaurus -->

			<!-- all_thesaurus_Titles: niet gebruikt, dus uitgecommentarieerd voor nu -->
			<!-- <sch:let name="all_thesaurus_Titles" value="ancestor::gmd:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title"/> -->

			<sch:let name="thesaurus_TitleString" value="normalize-space(gmd:title/gco:CharacterString)"/>
			<sch:let name="thesaurus_TitleURI" value="normalize-space(gmd:title/gmx:Anchor[string-length(normalize-space(text())) > 0]/@xlink:href)"/>

			<!-- 5.2.15 Thesaurusdatum https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#thesaurusdatum -->
			<sch:let name="thesaurus_publicationDateSring" value="string(gmd:date[./gmd:CI_Date/gmd:dateType/*/@codeListValue='publication']/*/gmd:date/gco:Date)"/>
			<sch:let name="thesaurus_creationDateString" value="string(gmd:date[./gmd:CI_Date/gmd:dateType/*/@codeListValue='creation']/*/gmd:date/gco:Date)"/>
			<sch:let name="thesaurus_revisionDateString" value="string(gmd:date[./gmd:CI_Date/gmd:dateType/*/@codeListValue='revision']/*/gmd:date/gco:Date)"/>
			<sch:let name="thesaurus_PublicationDate" value="((number(substring(substring-before($thesaurus_publicationDateSring,'-'),1,4)) &gt; 1000 ))"/>
			<sch:let name="thesaurus_CreationDate" value="((number(substring(substring-before($thesaurus_creationDateString,'-'),1,4)) &gt; 1000 ))"/>
			<sch:let name="thesaurus_RevisionDate" value="((number(substring(substring-before($thesaurus_revisionDateString,'-'),1,4)) &gt; 1000 ))"/>

            <!-- Thesaurus titel alleen voor INSPIRE -->
			<!--

			<sch:assert id="INSPIRE Thesaurus title (ISO nr. 360)" test="$all_thesaurus_Titles[normalize-space(*/text()) = 'GEMET - INSPIRE themes, version 1.0']">Thesaurus title (ISO nr. 360) ontbreekt of heeft de verkeerde waarde. Eén Thesaurus titel dient de waarde 'GEMET - INSPIRE themes, version 1.0 ' te bevatten.</sch:assert>
			 <sch:report id="INSPIRE Thesaurus title (ISO nr. 360) info" test="$thesaurus_Title">Thesaurus title (ISO nr. 360) is: <sch:value-of select="$thesaurus_Title"/></sch:report>
			-->
        	<!-- Eind Thesaurus titel alleen voor INSPIRE-->

        	<!-- Thesaurus datum en datumtype 5.2.15 Thesaurusdatum https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#thesaurusdatum en
			 5.2.16 Thesaurusdatum type https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#thesaurusdatum-type -->
			 <!-- TODO: check if it is allowed not to provide a thesaurus title? -->
			<sch:assert id="thesaurus_datum__ISO_nr.394__en_datumtype__ISO_nr._395_" test="($thesaurus_TitleString or $thesaurus_TitleURI) and ($thesaurus_CreationDate or $thesaurus_PublicationDate or $thesaurus_RevisionDate)">Een thesaurus datum (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#thesaurusdatum) en datumtype (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#thesaurusdatum-type) is verplicht als Thesaurus title (https://docs.geostandaarden.nl/md/mdprofiel-iso19115/#thesaurus) is opgegeven. Datum formaat moet YYYY-MM-DD zijn. (Thesaurus: <sch:value-of select="$thesaurus_TitleString"/><sch:value-of select="$thesaurus_TitleURI"/>) </sch:assert>

		</sch:rule>

		<!-- new in profile v2.0: account for gmx:Anchor -->
		<sch:rule id="INSPIRE_Thesaurus_trefwoorden" context="//gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords
			[normalize-space(gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gco:CharacterString) = 'GEMET - INSPIRE themes, version 1.0' or gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gmx:Anchor/@xlink:href = 'http://www.eionet.europa.eu/gemet/nl/inspire-themes/']
			/gmd:MD_Keywords/gmd:keyword">

			<!-- Controlled originating vocabulary -->
			<sch:let name="quote" value="&quot;'&quot;"/>
			<sch:assert id="INSPIRE_Trefwoorden__ISO_nr._53_" test="((normalize-space(current())='Administratieve eenheden'
)
		        or (normalize-space(current())='Adressen'
)
		        or (normalize-space(current())='Atmosferische omstandigheden'
)
		        or (normalize-space(current())='Beschermde gebieden'
)
		        or (normalize-space(current())='Biogeografische gebieden'
)
		        or (normalize-space(current())='Bodem')
		         or (normalize-space(current())='Bodemgebruik')
		         or (normalize-space(current())='Energiebronnen')
		         or (normalize-space(current())='Faciliteiten voor landbouw en aquacultuur')
		         or (normalize-space(current())='Faciliteiten voor productie en industrie')
		        or (normalize-space(current())=concat('Gebieden met natuurrisico',$quote,'s'))
		         or (normalize-space(current())='Gebiedsbeheer, gebieden waar beperkingen gelden, gereguleerde gebieden en rapportage-eenheden')
		         or (normalize-space(current())='Gebouwen')
		         or (normalize-space(current())='Geografisch rastersysteem')
		         or (normalize-space(current())='Geografische namen')
		         or (normalize-space(current())='Geologie')
		         or (normalize-space(current())='Habitats en biotopen')
		         or (normalize-space(current())='Hoogte')
		         or (normalize-space(current())='Hydrografie')
		         or (normalize-space(current())='Kadastrale percelen')
		         or (normalize-space(current())='Landgebruik')
		         or (normalize-space(current())='Menselijke gezondheid en veiligheid')
		         or (normalize-space(current())='Meteorologische geografische kenmerken')
		         or (normalize-space(current())='Milieubewakingsvoorzieningen')
		         or (normalize-space(current())='Minerale bronnen')
		         or (normalize-space(current())='Nutsdiensten en overheidsdiensten')
		         or (normalize-space(current())='Oceanografische geografische kenmerken')
		         or (normalize-space(current())='Orthobeeldvorming')
		         or (normalize-space(current())='Spreiding van de bevolking — demografie')
		         or (normalize-space(current())='Spreiding van soorten')
		         or (normalize-space(current())='Statistische eenheden')
		         or (normalize-space(current())='Systemen voor verwijzing door middel van coördinaten')
		         or (normalize-space(current())='Vervoersnetwerken')
		         or (normalize-space(current())='Zeegebieden'))">
Deze keywords moeten uit GEMET- INSPIRE themes thesaurus komen. Gevonden keywords: <sch:value-of select="./*[../gco:CharacterString or ../gmx:Anchor]"/></sch:assert>

		<!--eind  Controlled originating vocabulary -  -->


		 <!--  voor externe thesaurus
 		-->
		 <!--
     		<sch:assert id="INSPIRE thesaurus Trefwoorden (ISO nr. 53)" test="$gemet-nl//skos:prefLabel[normalize-space(text()) = normalize-space(current())]">Keywords [<sch:value-of select="$gemet-nl//skos:prefLabel "/>]   moeten uit GEMET- INSPIRE themes thesaurus komen. gevonden keywords: <sch:value-of select="."/></sch:assert>
		 -->

		</sch:rule>


	</sch:pattern>
</sch:schema>
