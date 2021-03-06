﻿// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

namespace PSDocs.Pipeline
{
    internal sealed class InputPathBuilder : PathBuilder
    {
        public InputPathBuilder(IPipelineWriter logger, string basePath, string searchPattern, PathFilter filter)
            : base(logger, basePath, searchPattern, filter) { }
    }
}
