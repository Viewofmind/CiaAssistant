/**
 * Cia Happiness Mode Skill
 * Automatically switches to the Zephyr happiness model when you say "Make me happy"
 *
 * Installation:
 * 1. Copy this file to ~/.moltbot/skills/cia-happiness.js
 * 2. Enable in your config: { "skills": { "enabled": ["cia-happiness"] } }
 * 3. Make sure you've pulled the model: ollama pull tomasmcm/zephyr-1b-olmo-sft-qlora
 */

// Model IDs
const HAPPINESS_MODEL = 'ollama/tomasmcm/zephyr-1b-olmo-sft-qlora';
const PRIMARY_MODEL = 'primary'; // Will use whatever is configured as primary

// Trigger phrases
const HAPPY_TRIGGERS = [
  'make me happy',
  'cheer me up',
  'i need some cheer',
  'switch to happy mode',
  'use happiness mode',
  'happiness mode on',
  'make it cheerful'
];

const NORMAL_TRIGGERS = [
  'back to normal',
  'normal mode',
  'switch back',
  'regular mode',
  'happiness mode off',
  'serious mode'
];

/**
 * Check if message contains any of the trigger phrases
 */
function containsTrigger(message, triggers) {
  const lowerMessage = message.toLowerCase().trim();
  return triggers.some(trigger => lowerMessage.includes(trigger));
}

/**
 * Main skill export
 * This follows the Moltbot skill pattern
 */
module.exports = {
  name: 'cia-happiness',
  description: 'Switches to happiness mode when triggered by specific phrases',
  version: '1.0.0',

  /**
   * Execute the skill
   * @param {Object} context - Moltbot execution context
   * @returns {Object|null} Response or null if not triggered
   */
  async execute(context) {
    const message = context.message || context.text || '';

    // Check for happiness mode trigger
    if (containsTrigger(message, HAPPY_TRIGGERS)) {
      // Switch to happiness model
      if (context.switchModel) {
        await context.switchModel(HAPPINESS_MODEL);
      }

      return {
        response: "🎉 Switching to happiness mode! Let's make this conversation cheerful and uplifting! What would bring you joy today?",
        model: HAPPINESS_MODEL,
        metadata: {
          mode: 'happiness',
          triggeredBy: 'phrase'
        }
      };
    }

    // Check for normal mode trigger
    if (containsTrigger(message, NORMAL_TRIGGERS)) {
      // Switch back to primary model
      if (context.switchModel) {
        await context.switchModel(PRIMARY_MODEL);
      }

      return {
        response: "👔 Switching back to normal mode. How can I assist you?",
        model: PRIMARY_MODEL,
        metadata: {
          mode: 'normal',
          triggeredBy: 'phrase'
        }
      };
    }

    // No trigger found, let the message pass through
    return null;
  },

  /**
   * Hooks for message preprocessing
   */
  hooks: {
    // Pre-process messages before they reach the agent
    beforeMessage: async (context) => {
      const result = await module.exports.execute(context);
      if (result) {
        // Store the current mode in context
        context.happinessMode = result.metadata.mode === 'happiness';
      }
      return result;
    }
  },

  /**
   * Configuration schema
   */
  config: {
    happinessModel: {
      type: 'string',
      default: HAPPINESS_MODEL,
      description: 'The model to use for happiness mode'
    },
    customTriggers: {
      type: 'array',
      default: [],
      description: 'Additional custom trigger phrases for happiness mode'
    },
    enabled: {
      type: 'boolean',
      default: true,
      description: 'Enable or disable the happiness mode skill'
    }
  }
};

/**
 * For TypeScript/ESM compatibility
 */
if (typeof module.exports.default === 'undefined') {
  module.exports.default = module.exports;
}
