import {PolymerElement} from '@polymer/polymer/polymer-element.js';
import '@polymer/iron-icon/iron-icon.js';
import '@vaadin/vaadin-text-field/src/vaadin-integer-field.js';
import '@vaadin/vaadin-text-field/src/vaadin-number-field.js';
import '@vaadin/vaadin-text-field/src/vaadin-text-field.js';
import '@vaadin/vaadin-button/src/vaadin-button.js';
import '@vaadin/vaadin-form-layout/src/vaadin-form-layout.js';
import '@vaadin/vaadin-combo-box/src/vaadin-combo-box.js';
import '../../../styles/shared-styles.js';
import {html} from '@polymer/polymer/lib/utils/html-tag.js';

class OrderItemEditor extends PolymerElement {
    static get template() {
        return html`
    <style include="shared-styles">
      .product {
        margin-bottom: 1em;
        box-shadow: 0 -3px 3px -3px var(--lumo-shade-20pct);
      }

      .delete {
        min-width: 2em;
        padding: 0;
      }

      @media (max-width: 700px) {
        vaadin-form-layout {
          --vaadin-form-layout-column-spacing: 1em;
        }
      }

      .money {
       /* text-align: right;*/
        line-height: 2.5em;
      }

      /* Workaround for vertically distorted elements inside a flex container in IE11 */
      .self-start {
        align-self: flex-start;
      }
    </style>

    <vaadin-form-layout id="form1">

      <vaadin-form-layout id="form2" colspan="16" class="product" style="flex: auto;">
        <vaadin-combo-box id="products" colspan="8" index="[[index]]"></vaadin-combo-box>
        <vaadin-number-field id="amount" colspan="4" index="[[index]]" class="self-start"
          min="1" max="15" has-controls prevent-invalid-input></vaadin-number-field>
      
        <vaadin-number-field  id="price" colspan="2" class="money">[[price]]</vaadin-number-field>
        <div id="materialSquaring" colspan="2" >[[materialSquaring]]</div>
        <!--<vaadin-text-field id="comment" colspan="12" placeholder="Details" index="[[index]]"></vaadin-text-field>-->
        <vaadin-horizontal-layout id="layWithParams" colspan="16">
            <vaadin-combo-box id="width" colspan="2" index="[[index]]" style="padding-right: 10px" ></vaadin-combo-box>  
            <vaadin-combo-box id="materialClass" colspan="2" index="[[index]]" style="padding-right: 10px"></vaadin-combo-box>
            <vaadin-combo-box id="materialCover" colspan="2" index="[[index]]" style="padding-right: 10px"></vaadin-combo-box>
            <vaadin-combo-box id="materialColor" colspan="2" index="[[index]]" style="padding-right: 10px"></vaadin-combo-box>
            <vaadin-number-field id="height" colspan="2" index="[[index]]"></vaadin-number-field>  
          <!--  <vaadin-text-field id="materialSquaring" colspan="2" index="[[index]]"></vaadin-text-field>  -->
        </vaadin-horizontal-layout>
      </vaadin-form-layout>

      <vaadin-button class="delete self-start" id="delete" colspan="2" index="[[index]]">
        <iron-icon icon="vaadin:close-small"></iron-icon>
      </vaadin-button>

      
    </vaadin-form-layout>

`;
    }

    static get is() {
        return 'order-item-editor';
    }

    ready() {
        super.ready();

        // Not using attributes since Designer does not suppor single-quote attributes
        this.$.form1.responsiveSteps = [
            {columns: 24}
        ];
        this.$.form2.responsiveSteps = [
            {columns: 8, labelsPosition: 'top'},
            {minWidth: '500px', columns: 16, labelsPosition: 'top'}
        ];
    }
}

window.customElements.define(OrderItemEditor.is, OrderItemEditor);
