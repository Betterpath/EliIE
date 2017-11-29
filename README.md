# EliIE 

**A CTEC Parser**

## Introduction

A parser designed for free text clinical trial eligibility criteria (CTEC). Parsing free text CTEC and formalizing into [OMOP CDM v5 table](http://omop.org/CDM). The parser was trained on 250 clinical trials on Alzheimer's. The annotation guidelines is in folder Supple Materials.

Developed in [Dr. Chunhua Weng's lab](http://people.dbmi.columbia.edu/~chw7007) in Department of Biomedical Informatics at Columbia

__Author__: Tian Kang<br>
__Affiliation__: Department of Biomedical Informatics, Columbia University<br>
__Contact Email__: tk2624@cumc.columbia.edu<br>
__Last update__: June 20, 2016  (add Negation detection in NER step)<br>
__Version__: 1.0

Primary steps:

1. __Entity recogntion__
2. __Attribute recognition__
3. __Clinical relation identification__
4. __Data standardization__

Exmaple input:

```xml
Age 70 years or older.
Must have a clinical diagnosis of Alzheimer's Disease.
Life expectancy less than 1 year.
Subjects must be in reasonably good health, based on medical history, physical examination, vital signs, and ECG.
Subjects with a past or current history of seizures cannot participate.
Subjects with clinically significant heart disease, pulmonary disease, diabetes, neurologic or psychiatric disease (Group 1 subjects must have Alzheimer's Disease), or any other illness that could interfere with interpretation of study results.
Current use of donepezil, rivastigmine or galantamine.
GDS-5 score < 6.
Within the previous 2 years, unstable and clinically siginificant cardivascular disease.
```

Example output:

```xml
<root>
  <sent>
    <text>Age 70 years or older .</text>
    <entity class="Observation" index="T1" negated="N" relation="T2:has_value" start="0"> Age </entity>
    <attribute class="Measurement" index="T2" start="1"> 70 years or older </attribute>
  </sent>
  <sent>
    <text>Must have a clinical diagnosis of Alzheimer's Disease .</text>
    <entity class="Condition" index="T3" negated="N" relation="None" start="6"> Alzheimer's Disease </entity>
  </sent>
  <sent>
    <text>Life expectancy less than 1 year .</text>
    <entity class="Observation" index="T4" negated="N" relation="T5:has_value" start="0"> Life expectancy </entity>
    <attribute class="Measurement" index="T5" start="2"> less than 1 year </attribute>
  </sent>
  <sent>
    <text>Subjects must be in reasonably good health , based on medical history , physical examination , vital signs , and ECG .</text>
    <attribute class="Qualifier" index="T6" start="5"> good </attribute>
    <entity class="Condition" index="T7" negated="N" relation="T6:modified_by" start="6"> health </entity>
    <entity class="Observation" index="T8" negated="N" relation="T6:modified_by" start="11"> history </entity>
    <entity class="Observation" index="T9" negated="N" relation="None" start="13"> physical examination </entity>
    <entity class="Observation" index="T10" negated="N" relation="None" start="16"> vital signs </entity>
    <entity class="Procedure_Device" index="T11" negated="N" relation="None" start="20"> ECG </entity>
  </sent>
  <sent>
    <text>Subjects with a past or current history of seizures cannot participate .</text>
    <entity class="Condition" index="T12" negated="Y" relation="None" start="8"> seizures cannot participate </entity>
  </sent>
  <sent>
    <text>Subjects with clinically significant heart disease , pulmonary disease , diabetes , neurologic or psychiatric disease ( Group 1 subjects must have Alzheimer's Disease ) , or any other illness that could interfere with interpretation of study results .</text>
    <attribute class="Qualifier" index="T13" start="2"> clinically significant </attribute>
    <entity class="Condition" index="T14" negated="N" relation="T13:modified_by" start="4"> heart disease </entity>
    <entity class="Condition" index="T15" negated="N" relation="None" start="7"> pulmonary disease </entity>
    <entity class="Condition" index="T16" negated="N" relation="None" start="10"> diabetes </entity>
    <entity class="Condition" index="T17" negated="N" relation="None" start="12"> neurologic or psychiatric disease </entity>
    <attribute class="Qualifier" index="T18" start="28"> other </attribute>
    <entity class="Condition" index="T19" negated="N" relation="T18:modified_by" start="29"> illness </entity>
  </sent>
  <sent>
    <text>Current use of donepezil , rivastigmine or galantamine .</text>
    <entity class="Drug" index="T20" negated="N" relation="None" start="3"> donepezil </entity>
    <entity class="Drug" index="T21" negated="N" relation="None" start="5"> rivastigmine </entity>
  </sent>
  <sent>
    <text>GDS-5 score smaller than 6 .</text>
    <entity class="Observation" index="T22" negated="N" relation="T23:has_value" start="0"> GDS-5 score </entity>
    <attribute class="Measurement" index="T23" start="2"> smaller than 6 </attribute>
  </sent>
  <sent>
    <text>Within the previous 2 years , unstable and clinically siginificant cardivascular disease .</text>
    <attribute class="Temporal_measurement" index="T24" start="0"> Within the previous 2 years </attribute>
    <attribute class="Qualifier" index="T25" start="6"> unstable </attribute>
    <attribute class="Qualifier" index="T26" start="8"> clinically siginificant </attribute>
    <entity class="Condition" index="T27" negated="N" relation="T24:has_temp|T26:modified_by|T25:modified_by" start="10"> cardivascular disease </entity>
  </sent>
</root>
```

## User Guide

First download all codes and decompress

__Fast Usage:__

1. open `wrapper_for_parsing.sh`
2. set the parameter lists to your task-based ones
3. run `sh wrapper_for_parsing.sh` and parsing results will be generated in XML files.

(See example output directly running `sh wrapper_for_parsing.sh` without changing)


__Step-by-stey Usage:__

1. NER step: run
    `python NamedEntityRecognition.py $1:<input directory> $2:<input text name> $3:<output directory>`
2. Clinical Relation:  run
    `python Relation.py $3:<output directory> $2:<input text name>`

__Example commands:__
    1. `python NamedEntityRecognition.py Tempfile test.txt Tempfile`
    2. `python Relation.py Tempfile test.txt` 

The example output would be Tempfile/test_NER.xml and Tempfile/test_Parsed.xml


## Prerequired Installation:

1.  This parser assumes [MetaMap](https://metamap.nlm.nih.gov) is installed and requires that the MetaMap support services are running. If you have MetaMap installed in `$MM`, these can be started as:
    `$MM/bin/skrmedpostctl start`
    `$MM/bin/wsdserverctl start`

    Go to `features_dir` and open `metamap_tag.sh`; follow the guidance to change the MetaMap root dir and start running

2.  Python package required:

    **nltk**<br>
    **networkx**<br>
    **codecs**<br>
    [**libsvm**](https://www.csie.ntu.edu.tw/~cjlin/libsvm)<br>
    [**practnlptools**](https://pypi.python.org/pypi/practnlptools/1.0)


## Functions Under Developing

1. Stadardize entities and attributes concepts using [OHDSI standards](http://www.ohdsi.org/data-standardization/)
2. Convert the final format into JSON
3. Extend use case to more diseases

## Docker

**Requirements**

- Docker

**Usage**

Make sure to rename `.env.example` to `.env` and update the AWS S3 credentials.

`Usage: ./deployment/bin/compose [up | eliie [bash | parse | skr | wsd]]`

[BACK TO TOP](#readme)
