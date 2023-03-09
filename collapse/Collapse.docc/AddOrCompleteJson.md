# Add or Complete A Json

How to add a new Topic , a new items , a new links and everything in The Json.

## Overview

**important**

To ensure that both JSON files for each language are correct, it is absolutely necessary for them to pass all the planned tests. These tests verify elements such as the number of topics in each file, the number of items, the coherence of the contents, etc. The tests are commented and visible in `CollapseTestJson.swift`.

### TopicElement
To add a new element to the Json, you will need to add the following Json.

```
{
    "uid": "1",
    "title": "Water",
    "subtitle": "subtitle of Water.",
    "image": "water",
    "links": [],
    "descriptionShort": "",
    "descriptionLong": "",
    "items": [],
    "isPremium": false
}
```

Then you will need to complete the topic's UID, title, mode, and other elements of ``TopicElement``.

### Items
Then, as many items as necessary must be added to the section, accompanied by different String types, as well as a 3-letter Id (e.g. AAA, ABB, etc.). These ids must be unique, otherwise the unit tests will not pass.


```
{
    "id": "AAC",
    "title": "",
    "mode": "",
    "subtitle": "",
    "image": "",
    "links": [],
    "content": [
        {
            "type": "",
            "value": ""
        }
    ]
}
```

Finally, different contents types such as text, list, bullet can be added.

### Links

To add a link please find a example : 
```
{
    "url": "http://google.com",
    "description": "description of link",
    "title": "title of the link"
}
```

## Lists Tests Toc check your jsons (fr and en)

- **`testIfSameTopicCountInFrenchAndInEnglish()`**

This test verifies that the number of topics in French and English JSON files is the same.

- **`testIfSameItemCountInFrenchAndInEnglish()`**

This test verifies that the number of items in French and English JSON files is the same.

- **`testIfModeIsCorrectInFrenchFiles()`**

This test verifies that each item in the French JSON files has a mode value that is one of the following: "essential", "intermediate", or "advanced".

- **`testIfModeIsCorrectInEnglishFiles()`**

This test verifies that each item in the English JSON files has a mode value that is one of the following: "essential", "intermediate", or "advanced".

- **`testIfTitleOrSubtitleISEmptyInFrenchFiles()`**

This test verifies that the length of the title and subtitle of each topic in the French JSON files is greater than 3.

- **`testIfTitleOrSubtitleISEmptyInEnglishFiles()`**

This test verifies that the length of the title and subtitle of each topic in the English JSON files is greater than 3.

- **`testIfItemsTitleOrSubtitleISEmptyInFrenchFiles()`**

This test verifies that the length of the title of each item in the French JSON files is greater than 3.

- **`testIfItemsTitleOrSubtitleISEmptyInEnglishFiles()`**

This test verifies that the length of the title of each item in the English JSON files is greater than 3.

- **`testIfNotSameIdInTopicInFrenchFiles()`**

This test verifies that each topic in the French JSON files has a unique ID.

- **`testIfNotSameIdInTopicInEnglishFiles()`**

This test verifies that each topic in the English JSON files has a unique ID.

- **`testIfNotSameIdInItemInFrenchFiles()`**

This test verifies that each item in the French JSON files has a unique ID.

- **`testIfNotSameIdInItemInEnglishFiles()`**

This test verifies that each item in the English JSON files has a unique 

