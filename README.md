# Nanoservice-ts Development Guidelines

This rule provides core guidelines for developing applications with Nanoservice-ts.

## What are Nanoservices?

Nanoservices are the smallest, independently executable units of backend functionality. They are:
- Focused on a single responsibility (SRP)
- Lightweight and modular
- Independently executable
- Containerized for isolation and scalability

## Core Principles

1. **Single Responsibility**: Each nanoservice should do exactly one thing well
2. **Modularity**: Components should be reusable across different workflows
3. **Type Safety**: Use TypeScript's type system throughout
4. **Error Handling**: Implement proper error handling in all components
5. **Testing**: Write comprehensive tests for all components

## Project Structure

A well-organized Nanoservice-ts project should follow this structure:

```
src/
├── nodes/                # Node implementations
│   ├── category1/
│   │   ├── node1/
│   │   │   ├── index.ts
│   │   │   ├── inputSchema.ts
│   │   │   ├── config.json
│   │   │   └── tests/
│   │   └── node2/
│   └── category2/
├── workflows/            # Workflow definitions
│   ├── workflow1.ts
│   ├── workflow2.ts
│   └── tests/
├── triggers/             # Custom trigger implementations
├── utils/                # Utility functions
└── index.ts              # Main entry point
```

## Naming Conventions

- **Files**: Use kebab-case for file names (e.g., `data-transformer.ts`)
- **Classes**: Use PascalCase for class names (e.g., `DataTransformerNode`)
- **Variables**: Use camelCase for variable names (e.g., `inputData`)
- **Constants**: Use UPPER_SNAKE_CASE for constants (e.g., `MAX_RETRY_COUNT`)
- **Types/Interfaces**: Use PascalCase for type definitions (e.g., `InputType`)
- **Workflows**: Use kebab-case for workflow names (e.g., `user-registration`)

## Import Patterns

Use consistent import patterns:

```typescript
// External dependencies
import type { Context } from "@nanoservice-ts/shared";
import { NanoService } from "@nanoservice-ts/runner";
import { createWorkflow } from "@nanoservice-ts/workflow-helper";

// Internal imports
import { validateInput } from "../../utils/validation";
```

## Documentation

Always include proper documentation:

- Add JSDoc comments for classes and methods
- Include a README.md for each node
- Document input/output types clearly
- Explain complex logic with inline comments

## Additional Resources

For more detailed guidelines, refer to these specific rules:

- @node_development - Guidelines for developing Nanoservice-ts Nodes
- @workflow_development - Guidelines for developing Nanoservice-ts Workflows

## Common Pitfalls to Avoid

1. **Violating Single Responsibility**: Don't try to do too much in a single node
2. **Missing Error Handling**: Always handle errors appropriately
3. **Inadequate Testing**: Write comprehensive tests for all components
4. **Poor Type Definitions**: Use TypeScript's type system effectively
5. **Hardcoded Values**: Use configuration and environment variables
6. **Tight Coupling**: Design nodes to be reusable and independent
7. **Inconsistent Naming**: Follow naming conventions consistently
8. **Missing Documentation**: Document your code thoroughly

-----------------------------------------------------------------------------------------------------------------

# How to develop Nanoservice-ts Nodes

## Overview of Nanoservice-ts Node Development

1. Nodes are the fundamental building blocks of Nanoservice-ts applications
2. Each node should follow the Single Responsibility Principle (SRP)
3. Nodes are implemented as TypeScript classes that extend the `NanoService` base class
4. Nodes must include proper input schema definitions and configuration

## Node File Structure

A properly structured node should include these files:

```
my-node/
├── index.ts           # Main implementation file
├── inputSchema.ts     # Input schema definition
├── config.json        # Node configuration
├── README.md          # Documentation
└── tests/             # Test files
    └── index.test.ts  # Unit tests
```

## 🚨 CRITICAL INSTRUCTIONS FOR NODE IMPLEMENTATION 🚨

As an AI language model, you MUST NOT generate any of the following code patterns, as they are INCORRECT and will BREAK the application:

```typescript
// ❌ NEVER GENERATE THIS CODE - IT WILL BREAK THE APPLICATION

// Missing NanoService extension
export default class MyNode {                // ❌ BREAKS APPLICATION
  async handle(ctx, inputs) {                // ❌ BREAKS APPLICATION
    return { result: "some result" };        // ❌ BREAKS APPLICATION
  }                                          // ❌ BREAKS APPLICATION
}                                            // ❌ BREAKS APPLICATION

// Missing type parameters
export default class MyNode extends NanoService { // ❌ BREAKS APPLICATION
  constructor() {                                 // ❌ BREAKS APPLICATION
    super();                                      // ❌ BREAKS APPLICATION
  }                                               // ❌ BREAKS APPLICATION
                                                  
  async handle(ctx, inputs) {                     // ❌ BREAKS APPLICATION
    return { result: "some result" };             // ❌ BREAKS APPLICATION
  }                                               // ❌ BREAKS APPLICATION
}                                                 // ❌ BREAKS APPLICATION

// Incorrect constructor initialization
export default class MyNode extends NanoService<InputType, OutputType> { // ❌ BREAKS APPLICATION
  // Missing constructor or incorrect initialization                     // ❌ BREAKS APPLICATION
  async handle(ctx: Context, inputs: InputType): Promise<OutputType> {   // ❌ BREAKS APPLICATION
    return { result: "some result" };                                    // ❌ BREAKS APPLICATION
  }                                                                      // ❌ BREAKS APPLICATION
}                                                                        // ❌ BREAKS APPLICATION
```

Instead, you MUST ALWAYS generate ONLY this pattern:

```typescript
// ✅ ALWAYS GENERATE THIS EXACT PATTERN

import type { Context } from "@nanoservice-ts/shared";
import { NanoService } from "@nanoservice-ts/runner";

// Define input and output types
type InputType = {
  // Input parameters
};

type OutputType = {
  // Output structure
};

export default class MyNode extends NanoService<InputType, OutputType> {
  constructor() {
    super();
    this.flow = true; // or false based on requirements
    this.contentType = "application/json"; // or appropriate content type
  }

  async handle(ctx: Context, inputs: InputType): Promise<OutputType> {
    try {
      // Implementation logic
      return {
        // Return result
      };
    } catch (error) {
      // Error handling
      ctx.logger.error("Error in MyNode", { error });
      throw error;
    }
  }
}
```

## Input Schema Definition

Always define a proper input schema in a separate `inputSchema.ts` file:

```typescript
// ✅ CORRECT INPUT SCHEMA DEFINITION

export const inputSchema = {
  $schema: "http://json-schema.org/draft-07/schema#",
  title: "My Node Input Schema",
  type: "object",
  properties: {
    // Define properties here
    param1: { 
      type: "string",
      description: "Description of param1"
    },
    param2: { 
      type: "number",
      description: "Description of param2"
    }
  },
  required: ["param1"] // List required properties
};
```

## Node Configuration

Always include a proper `config.json` file:

```json
{
  "name": "my-node",
  "version": "1.0.0",
  "description": "A node that performs a specific task",
  "category": "utility",
  "author": "Your Name",
  "tags": ["utility", "processing"],
  "inputs": [
    {
      "name": "param1",
      "description": "Description of param1",
      "type": "string",
      "required": true
    },
    {
      "name": "param2",
      "description": "Description of param2",
      "type": "number",
      "required": false
    }
  ],
  "outputs": [
    {
      "name": "result",
      "description": "Description of result",
      "type": "string"
    }
  ]
}
```

## Naming Conventions

- **Node Class Names**: Use PascalCase with a `Node` suffix (e.g., `DataTransformerNode`)
- **File Names**: Use kebab-case (e.g., `data-transformer`)
- **Variable Names**: Use camelCase (e.g., `inputData`)
- **Type Definitions**: Use PascalCase (e.g., `InputType`, `OutputType`)

## Error Handling

Always implement proper error handling in your nodes:

```typescript
async handle(ctx: Context, inputs: InputType): Promise<OutputType> {
  try {
    // Implementation logic
    return {
      // Return result
    };
  } catch (error) {
    // Log the error with context
    ctx.logger.error("Error in node execution", { 
      error, 
      nodeId: this.constructor.name,
      inputs 
    });
    
    // Rethrow or handle based on requirements
    throw new Error(`Operation failed: ${error.message}`);
  }
}
```

## Common Node Patterns

### Data Transformation Node

```typescript
import type { Context } from "@nanoservice-ts/shared";
import { NanoService } from "@nanoservice-ts/runner";

type InputType = {
  data: Array<Record<string, any>>;
};

type OutputType = {
  transformedData: Array<Record<string, any>>;
  count: number;
};

export default class DataTransformerNode extends NanoService<InputType, OutputType> {
  constructor() {
    super();
    this.flow = true;
    this.contentType = "application/json";
  }

  async handle(ctx: Context, inputs: InputType): Promise<OutputType> {
    try {
      const transformedData = inputs.data.map(item => ({
        // Transform logic here
      }));

      return {
        transformedData,
        count: transformedData.length
      };
    } catch (error) {
      ctx.logger.error("Error transforming data", { error });
      throw new Error(`Data transformation failed: ${error.message}`);
    }
  }
}
```

### API Integration Node

```typescript
import type { Context } from "@nanoservice-ts/shared";
import { NanoService } from "@nanoservice-ts/runner";

type InputType = {
  apiUrl: string;
  method: string;
  headers?: Record<string, string>;
  data?: any;
};

type OutputType = {
  statusCode: number;
  data: any;
};

export default class ApiIntegrationNode extends NanoService<InputType, OutputType> {
  constructor() {
    super();
    this.flow = true;
    this.contentType = "application/json";
  }

  async handle(ctx: Context, inputs: InputType): Promise<OutputType> {
    try {
      // API integration logic
      const response = await fetch(inputs.apiUrl, {
        method: inputs.method,
        headers: inputs.headers || {},
        body: inputs.data ? JSON.stringify(inputs.data) : undefined
      });
      
      const data = await response.json();
      
      return {
        statusCode: response.status,
        data
      };
    } catch (error) {
      ctx.logger.error("API request failed", { error });
      throw new Error(`API request failed: ${error.message}`);
    }
  }
}
```

## Testing Nodes

Always write comprehensive tests for your nodes:

```typescript
import { createTestContext } from '@nanoservice-ts/testing';
import MyNode from '../index';

describe('MyNode', () => {
  let node;
  let ctx;
  
  beforeEach(() => {
    node = new MyNode();
    ctx = createTestContext();
  });
  
  test('should process valid input correctly', async () => {
    const inputs = { /* test inputs */ };
    const result = await node.handle(ctx, inputs);
    expect(result).toEqual({ /* expected output */ });
  });
  
  test('should handle invalid input appropriately', async () => {
    const inputs = { /* invalid inputs */ };
    await expect(node.handle(ctx, inputs)).rejects.toThrow();
  });
});
```

## Best Practices

1. **Follow Single Responsibility Principle**: Each node should do exactly one thing well
2. **Validate Inputs**: Always validate inputs before processing
3. **Handle Errors Gracefully**: Implement proper error handling
4. **Document Thoroughly**: Include clear documentation
5. **Test Comprehensively**: Write tests for various scenarios
6. **Consider Performance**: Optimize for efficiency
7. **Ensure Reusability**: Design nodes to be reusable
8. **Use Strong Typing**: Leverage TypeScript's type system
9. **Implement Logging**: Include appropriate logging
10. **Consider Security**: Address security concerns

-----------------------------------------------------------------------------------------------------------------

# How to develop Nanoservice-ts Workflows

## Overview of Nanoservice-ts Workflow Development

1. Workflows connect multiple nodes to implement business logic
2. Each workflow starts with a trigger that initiates execution
3. Workflows define the data flow between nodes
4. Workflows can include conditional logic and error handling

## Workflow Structure

A workflow is defined programmatically in TypeScript and typically includes:

1. A unique name
2. A trigger definition
3. A sequence of nodes
4. Data flow mappings between nodes
5. Error handling configuration

## 🚨 CRITICAL INSTRUCTIONS FOR WORKFLOW IMPLEMENTATION 🚨

As an AI language model, you MUST NOT generate any of the following code patterns, as they are INCORRECT and will BREAK the application:

```typescript
// ❌ NEVER GENERATE THIS CODE - IT WILL BREAK THE APPLICATION

// Missing createWorkflow import
export const myWorkflow = {                  // ❌ BREAKS APPLICATION
  name: "my-workflow",                       // ❌ BREAKS APPLICATION
  trigger: new HttpTrigger({                 // ❌ BREAKS APPLICATION
    path: "/my-endpoint",                    // ❌ BREAKS APPLICATION
    method: "POST"                           // ❌ BREAKS APPLICATION
  }),                                        // ❌ BREAKS APPLICATION
  nodes: [                                   // ❌ BREAKS APPLICATION
    // Node definitions                      // ❌ BREAKS APPLICATION
  ]                                          // ❌ BREAKS APPLICATION
};                                           // ❌ BREAKS APPLICATION

// Incorrect node structure
export const myWorkflow = createWorkflow({   // ❌ BREAKS APPLICATION
  name: "my-workflow",                       // ❌ BREAKS APPLICATION
  trigger: new HttpTrigger({                 // ❌ BREAKS APPLICATION
    path: "/my-endpoint",                    // ❌ BREAKS APPLICATION
    method: "POST"                           // ❌ BREAKS APPLICATION
  }),                                        // ❌ BREAKS APPLICATION
  nodes: [                                   // ❌ BREAKS APPLICATION
    "validate-input",                        // ❌ BREAKS APPLICATION
    "process-data"                           // ❌ BREAKS APPLICATION
  ]                                          // ❌ BREAKS APPLICATION
});                                          // ❌ BREAKS APPLICATION

// Missing node references
export const myWorkflow = createWorkflow({   // ❌ BREAKS APPLICATION
  name: "my-workflow",                       // ❌ BREAKS APPLICATION
  trigger: new HttpTrigger({                 // ❌ BREAKS APPLICATION
    path: "/my-endpoint",                    // ❌ BREAKS APPLICATION
    method: "POST"                           // ❌ BREAKS APPLICATION
  }),                                        // ❌ BREAKS APPLICATION
  nodes: [                                   // ❌ BREAKS APPLICATION
    {                                        // ❌ BREAKS APPLICATION
      name: "validate-input"                 // ❌ BREAKS APPLICATION
      // Missing node reference              // ❌ BREAKS APPLICATION
    }                                        // ❌ BREAKS APPLICATION
  ]                                          // ❌ BREAKS APPLICATION
});                                          // ❌ BREAKS APPLICATION
```

Instead, you MUST ALWAYS generate ONLY this pattern:

```typescript
// ✅ ALWAYS GENERATE THIS EXACT PATTERN

import { createWorkflow } from "@nanoservice-ts/workflow-helper";
import { HttpTrigger } from "@nanoservice-ts/triggers/http";
// Import other trigger types as needed

export const myWorkflow = createWorkflow({
  name: "my-workflow",
  description: "Description of what the workflow does",
  trigger: new HttpTrigger({
    path: "/my-endpoint",
    method: "POST",
    cors: true,  // Optional
    auth: true   // Optional
  }),
  nodes: [
    {
      name: "first-node",
      node: "category/node-name@version",
      inputs: {
        // Map inputs to the node
        param1: "value1",
        param2: "{{trigger.body.param2}}"
      }
    },
    {
      name: "second-node",
      node: "category/node-name@version",
      inputs: {
        // Map outputs from first-node to inputs of second-node
        inputParam: "{{first-node.outputParam}}"
      }
    }
  ],
  // Optional error handler
  errorHandler: {
    node: "error/handler@version",
    inputs: {
      error: "{{error}}",
      workflow: "{{workflow.name}}",
      node: "{{node.name}}"
    }
  }
});
```

## Trigger Types

### HTTP Trigger

Use for workflows triggered by HTTP requests:

```typescript
import { HttpTrigger } from "@nanoservice-ts/triggers/http";

const trigger = new HttpTrigger({
  path: "/api/endpoint",
  method: "POST", // GET, PUT, DELETE, etc.
  cors: true,     // Enable CORS
  auth: true      // Require authentication
});
```

### Schedule Trigger

Use for workflows triggered on a schedule:

```typescript
import { ScheduleTrigger } from "@nanoservice-ts/triggers/schedule";

const trigger = new ScheduleTrigger({
  cron: "0 * * * *", // Cron expression (every hour)
  timezone: "UTC"    // Timezone
});
```

### Event Trigger

Use for workflows triggered by events:

```typescript
import { EventTrigger } from "@nanoservice-ts/triggers/event";

const trigger = new EventTrigger({
  event: "message.received",
  source: "message-queue"
});
```

### Database Trigger

Use for workflows triggered by database changes:

```typescript
import { DatabaseTrigger } from "@nanoservice-ts/triggers/database";

const trigger = new DatabaseTrigger({
  database: "my-database",
  table: "users",
  operation: "insert" // insert, update, delete
});
```

## Data Flow Between Nodes

Use template syntax to map data between nodes:

```typescript
nodes: [
  {
    name: "first-node",
    node: "category/first-node@1.0.0",
    inputs: {
      // Static values
      param1: "static-value",
      
      // From trigger
      param2: "{{trigger.body.param2}}",
      
      // From environment
      apiKey: "{{env.API_KEY}}"
    }
  },
  {
    name: "second-node",
    node: "category/second-node@1.0.0",
    inputs: {
      // From previous node
      data: "{{first-node.result}}",
      
      // Combine values
      message: "Processing data from {{first-node.metadata.source}}"
    }
  }
]
```

## Conditional Logic

Implement conditional execution of nodes:

```typescript
nodes: [
  {
    name: "check-condition",
    node: "logic/condition-checker@1.0.0",
    inputs: {
      value: "{{trigger.body.value}}",
      threshold: 100
    }
  },
  {
    name: "high-value-process",
    node: "process/high-value@1.0.0",
    inputs: {
      data: "{{trigger.body}}"
    },
    condition: "{{check-condition.result}} === 'above'"
  },
  {
    name: "low-value-process",
    node: "process/low-value@1.0.0",
    inputs: {
      data: "{{trigger.body}}"
    },
    condition: "{{check-condition.result}} === 'below'"
  }
]
```

## Error Handling

Always implement proper error handling in your workflows:

```typescript
export const myWorkflow = createWorkflow({
  name: "my-workflow",
  trigger: new HttpTrigger({ path: "/my-endpoint", method: "POST" }),
  nodes: [
    // Node definitions
  ],
  errorHandler: {
    node: "error/handler@1.0.0",
    inputs: {
      error: "{{error}}",
      workflow: "{{workflow.name}}",
      node: "{{node.name}}",
      timestamp: "{{Date.now()}}",
      // Additional context
      severity: "high",
      notifyAdmin: true
    }
  }
});
```

## Common Workflow Patterns

### API Endpoint Workflow

```typescript
import { createWorkflow } from "@nanoservice-ts/workflow-helper";
import { HttpTrigger } from "@nanoservice-ts/triggers/http";

export const apiEndpointWorkflow = createWorkflow({
  name: "api-endpoint",
  description: "Handle API requests and return responses",
  trigger: new HttpTrigger({
    path: "/api/resource",
    method: "POST",
    cors: true,
    auth: true
  }),
  nodes: [
    // Validate input
    {
      name: "validate-input",
      node: "validation/input-validator@1.0.0",
      inputs: {
        schema: {
          // JSON schema for validation
        },
        data: "{{trigger.body}}"
      }
    },
    
    // Process request
    {
      name: "process-request",
      node: "business/processor@1.0.0",
      inputs: {
        data: "{{validate-input.data}}"
      }
    },
    
    // Format response
    {
      name: "format-response",
      node: "response/formatter@1.0.0",
      inputs: {
        data: "{{process-request.result}}",
        statusCode: 200
      }
    }
  ],
  errorHandler: {
    node: "error/api-error-handler@1.0.0",
    inputs: {
      error: "{{error}}",
      workflow: "{{workflow.name}}",
      node: "{{node.name}}"
    }
  }
});
```

### Data Processing Workflow

```typescript
import { createWorkflow } from "@nanoservice-ts/workflow-helper";
import { ScheduleTrigger } from "@nanoservice-ts/triggers/schedule";

export const dataProcessingWorkflow = createWorkflow({
  name: "data-processing",
  description: "Process data on a schedule",
  trigger: new ScheduleTrigger({
    cron: "0 0 * * *", // Daily at midnight
    timezone: "UTC"
  }),
  nodes: [
    // Fetch data
    {
      name: "fetch-data",
      node: "data/fetcher@1.0.0",
      inputs: {
        source: "database",
        query: {
          table: "raw_data",
          where: {
            processed: false
          },
          limit: 1000
        }
      }
    },
    
    // Transform data
    {
      name: "transform-data",
      node: "data/transformer@1.0.0",
      inputs: {
        data: "{{fetch-data.result}}"
      }
    },
    
    // Store results
    {
      name: "store-results",
      node: "data/storer@1.0.0",
      inputs: {
        data: "{{transform-data.transformedData}}",
        destination: {
          table: "processed_data"
        }
      }
    },
    
    // Update status
    {
      name: "update-status",
      node: "data/status-updater@1.0.0",
      inputs: {
        ids: "{{fetch-data.result.map(item => item.id)}}",
        table: "raw_data",
        updates: {
          processed: true,
          processedAt: "{{Date.now()}}"
        }
      }
    }
  ],
  errorHandler: {
    node: "error/data-processing-error-handler@1.0.0",
    inputs: {
      error: "{{error}}",
      workflow: "{{workflow.name}}",
      node: "{{node.name}}"
    }
  }
});
```

## Testing Workflows

Always write comprehensive tests for your workflows:

```typescript
import { createTestWorkflow } from '@nanoservice-ts/testing';
import { myWorkflow } from '../my-workflow';

describe('MyWorkflow', () => {
  let workflow;
  
  beforeEach(() => {
    workflow = createTestWorkflow(myWorkflow);
  });
  
  test('should execute workflow correctly', async () => {
    const input = { /* test input */ };
    const result = await workflow.execute(input);
    expect(result).toEqual({ /* expected output */ });
  });
  
  test('should handle errors appropriately', async () => {
    const input = { /* input that causes error */ };
    const result = await workflow.execute(input);
    expect(result.error).toBeDefined();
  });
});
```

## Best Practices

1. **Start with Clear Triggers**: Define how workflows are initiated
2. **Plan Node Sequence**: Determine the logical flow of operations
3. **Handle Errors Appropriately**: Implement error handling strategies
4. **Consider Conditional Logic**: Use branching when needed
5. **Document Data Flow**: Clearly document how data moves between nodes
6. **Test End-to-End**: Verify complete workflow functionality
7. **Monitor Performance**: Identify bottlenecks
8. **Use Meaningful Names**: Choose descriptive names for workflows and node instances
9. **Keep Workflows Focused**: Don't try to do too much in a single workflow
10. **Version Your Nodes**: Use semantic versioning for node references
