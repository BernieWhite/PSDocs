# Upgrade notes

This document contains notes to help upgrade from previous versions of PSDocs.

## Upgrade to v0.9.0

Follow these notes to upgrade to v0.9.0 from previous versions.

### Empty documents

Previously output would be generated from any `Document` block.

For example:

```powershell
Document 'WithTitle' {
    Title 'Read me'
    Metadata @{
        key = 'value'
    }
}
```

Documents that do not generate any body content are ignored.
If a document **only** sets a title or metadata the document is ignored.
To generate a document, set any body content.

For example:

```powershell
Document 'WithText' {
    Title 'Read me'

    'Some content'
}

Document 'WithBlockQuote' {
    Title 'Read me'

    'Some content' | BlockQuote
}
```

## Upgrade to v0.7.0

Follow these notes to upgrade to v0.7.0 from previous versions.

### Inline blocks

Previously a `Document` block and the command that generated the document could be called inline within the same script.

For example:

```powershell
Document 'SampleMessage' {
    'Testing 123.'
}

Sample -InputObject @{ }
```

Support for inline `Document` blocks has been removed.
Use the following steps to migrate inline blocks to a file if you previously used this feature:

- Create a new file ending with `.Doc.ps1` file extension.
For example `Sample.Doc.ps1`.
- Copy and paste the previous inline `Document` block into the file.
Multiple document blocks can be included in the same file.
- Update command-line to use `Invoke-PSDocument` instead of using the name of the document block directly.

Example `Sample.Doc.ps1`:

```powershell
Document 'SampleMessage' {
    'Testing 123.'
}
```

The cmdlet `Invoke-PSDocument` can be called as follows:

```powershell
Invoke-PSDocument -Path .\Sample.Doc.ps1 -Name SampleMessage;
```

On Linux, the file extension `.doc.ps1` is not automatically found by PSDocs because of file system case-sensitivity.
For consistency, use `.Doc.ps1` on all platforms.

### Helper functions

Previously helper functions could be defined with the default scope.

For example:

```powershell
function SampleHelperFn {
    # Do something
}

Document 'SampleDocument' {
    SampleHelperFn;
}
```

The execution model of PSDocs now uses a separate runspace sandbox.
Blocks are enumerated first then executed.
Helper functions can still be used however must be flagged with the global scope modifier.

For example:

```powershell
function global:SampleHelperFn {
    # Do something
}

Document 'SampleDocument' {
    SampleHelperFn;
}
```

### Script block usage of Note and Warning

Previously `Note` and `Warning` blocks could contain a script block.

For example:

```powershell
Document 'NoteScriptBlock' {
    Note {
        'A note'
    }
}
```

This syntax was deprecated as of v0.6.0, and has been removed as of v0.7.0.
Instead of using a script block, pipe the note or warning text to `Note`, `Warning`.

For example:

```powershell
Document 'NotePipe' {
    'A note' | Note
}
```

### Section -When parameter

Previously the `-When` parameter could be used with the section keyword.

For example:

```powershell
Document 'SectionWhen' {
    Section -When { $i -eq 0 } {
        'Sample section text.'
    }
}
```

The `-When` parameter was replaced with `-If` as of v0.6.0, and has been removed as of v0.7.0.
Instead of using `-When`, update section blocks to use `-If`.

For example:

```powershell
Document 'SectionIf' {
    Section -If { $i -eq 0 } {
        'Sample section text.'
    }
}
```
