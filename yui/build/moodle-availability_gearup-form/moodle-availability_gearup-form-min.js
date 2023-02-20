YUI.add("moodle-availability_gearup-form",function(l,e){M.availability_gearup=M.availability_gearup||{},M.availability_gearup.form=l.merge(M.core_availability.plugin,{achievements:null,quests:null,helphtml:null,helpiconhtml:null,_node:null,initInner:function(e){this.achievements=e.achievements,this.quests=e.quests,this.helphtml=e.helphtml,this.helpiconhtml=e.helpiconhtml},getNode:function(e){this._node||(i=l.Handlebars.compile(`
<div class="availability_gearup_frontend">
    <div>
        <label for="availability_gearup_missionid" class="sr-only">{{get_string "mission" "availability_gearup"}}</label>
        <select name="missionid" id="availability_gearup_missionid" class="custom-select">
            <optgroup label="{{get_string "quests" "availability_gearup"}}" data-type="quest">
                {{#each quests}}
                <option value="{{ value }}">{{ label }}</option>
                {{/each}}
            </optgroup>
            <optgroup label="{{get_string "achievements" "availability_gearup"}}" data-type="quest">
                {{#each achievements}}
                <option value="{{ value }}">{{ label }}</option>
                {{/each}}
            </optgroup>
        </select>
        <label for="availability_gearup_mode" class="sr-only"></label>
        <select name="mode" id="availability_gearup_mode" class="custom-select">
            {{#each modes}}
            <option value="{{ value }}">{{ label }}</option>
            {{/each}}
        </select>
        <a class="btn btn-link p-0" role="button"
            data-container="body" data-toggle="popover"
            data-content="{{ help.text }}"
            data-html="true" tabindex="0" data-trigger="focus">
            {{{ help.icon }}}
        </a>
    </div>
</div>`),this._node=l.Node.create(i({modes:[{value:5,label:M.util.get_string("isrecruit","availability_gearup")},{value:6,label:M.util.get_string("hasstarted","availability_gearup")},{value:1,label:M.util.get_string("isassigned","availability_gearup")},{value:2,label:M.util.get_string("isstarted","availability_gearup")},{value:3,label:M.util.get_string("iscompleted","availability_gearup")},{value:4,label:M.util.get_string("isended","availability_gearup")}],achievements:this.achievements.map(function(e){return{value:e.id,label:e.title}}),quests:this.quests.map(function(e){return{value:e.id,label:e.title}}),help:{text:this.helphtml,icon:this.helpiconhtml}})),l.one("#fitem_id_availabilityconditionsjson, .availability-field").delegate("change",function(){M.core_availability.form.update()},".availability_gearup select"));const a=this._node.cloneNode(!0);"undefined"!=typeof e.missionid&&a.one("[name=missionid]").set("value",e.missionid);var i="undefined"==typeof e.mode?4:e.mode;return a.one("[name=mode]").set("value",i),a},fillValue:function(e,a){const i=a.one("[name=missionid]"),l=a.one("[name=mode]");e.missionid=parseInt(i.get("value"),10),e.mode=parseInt(l.get("value"),10)},fillErrors:function(e,a){const i=a.one("[name=missionid]");a=parseInt(i.get("value"),10);(isNaN(a)||!a||a<0)&&e.push("availability_gearup:pleaseselectone")}})},"@VERSION@",{requires:["base","node","event","handlebars","moodle-core_availability-form"]});