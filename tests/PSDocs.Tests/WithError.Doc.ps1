# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

document 'InvalidCommand' {
    New-PSDocsInvalidCommand;
}

document 'InvalidCommandWithSection' {
    Section 'Invalid' {
        New-PSDocsInvalidCommand;
    }
}

document 'WithWriteError' {
    Write-Error -Message 'Verify Write-Error is raised as an exception';
}
